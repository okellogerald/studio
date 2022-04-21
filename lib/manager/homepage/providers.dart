import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/errors/source.dart';
import 'package:silla_studio/manager/courses_repository.dart';
import 'package:silla_studio/manager/lesson_page/providers/providers.dart';
import 'package:silla_studio/manager/onboarding/providers/user_details.dart';
import 'package:silla_studio/manager/topic_page/models/topic.dart';
import 'package:silla_studio/manager/topic_page/providers/providers.dart';
import 'models/course_overview.dart';
import 'models/homepage_state.dart';

final homepageNotifierProvider =
    StateNotifierProvider<HomepageNotifier, HomepageState>(
        (ref) => HomepageNotifier(ref));

class HomepageNotifier extends StateNotifier<HomepageState> {
  final StateNotifierProviderRef ref;
  HomepageNotifier(this.ref)
      : super(const HomepageState.loading('Getting data...'));

  var _currentOverview = CourseOverview.empty();

  Future<void> init() async {
    state = const HomepageState.loading('Getting data...');
    final courseRepository = ref.read(coursesRepositoryProvider);

    late CourseOverview overview;
    try {
      //if user has changed course / grade
      final prevCourseIds = ref.read(prevCourseIdsProvider);
      if (prevCourseIds.isNotEmpty) {
        final userData = ref.read(userDetailsProvider);
        if (userData.level.isEmpty) {
          overview = await courseRepository.getUserCourseOverview({
            'courseID': '${userData.courseId}',
            'gradeID': '${userData.gradeId}'
          });
        } else {
          overview = await courseRepository.getUserCourseOverview({
            'courseID': '${userData.courseId}',
            'gradeID': '${userData.gradeId}',
            'level': userData.level
          });
        }
        ref.refresh(prevCourseIdsProvider);
        _currentOverview = overview;
      } else {
        overview = await courseRepository.getUserCourseOverview();
        _currentOverview = overview;
      }
      state = HomepageState.content(overview);
    } catch (error) {
      state = HomepageState.failed(getErrorMessage(error));
    }
  }

  Future<void> refresh() async => await init();

  ///updates the topic's number of completed videos & the generalInfo number of
  ///classes to complete the grade-topics and the percentage as well, after
  ///lesson completion status is changed
  void update() {
    state = const HomepageState.loading('updating content...');
    //updated lesson
    final lesson = ref.read(currentLessonProvider);
    //updating general info
    final completedLessons = _currentOverview.generalInfo.completedLessons;
    log('$completedLessons');
    final generalInfo = _currentOverview.generalInfo.copyWith(
        lesson.isComplete ? completedLessons + 1 : completedLessons - 1);
    //updating continuing lesson
    var currentLesson = _currentOverview.currentLesson;
    if (lesson.id == _currentOverview.currentLesson.id) {
      currentLesson = _currentOverview.currentLesson
          .copyWith(completionStatus: lesson.completionStatus);
    }
    //updating the topic completed lessons count
    final topic = ref.read(currentTopicProvider);
    final topicList = List<Topic>.from(_currentOverview.topicList);
    final index = topicList.indexWhere((e) => e.id == topic.id);
    if (index == -1) throw 'topic is supposed to be in a list';
    final updatedTopic = _currentOverview.topicList[index]
        .copyWith(completedLessons: topic.completedLessons);
    topicList[index] = updatedTopic;
    //merging updates
    _currentOverview = CourseOverview(
        generalInfo: generalInfo,
        currentLesson: currentLesson,
        topicList: topicList);
    state = HomepageState.content(_currentOverview);
  }
}
