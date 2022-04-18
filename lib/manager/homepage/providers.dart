import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/errors/source.dart';
import 'package:silla_studio/manager/courses_repository.dart';
import 'package:silla_studio/manager/lesson_page/providers/providers.dart';
import 'package:silla_studio/manager/topic_page/models/topic.dart';
import 'package:silla_studio/manager/topic_page/providers/providers.dart';
import 'models/course_overview.dart';
import 'models/homepage_state.dart';

final gradeCompletedCountProvider = StateProvider<int>((ref) => 0);

final homepageNotifierProvider =
    StateNotifierProvider<HomepageNotifier, HomepageState>(
        (ref) => HomepageNotifier(ref));

class HomepageNotifier extends StateNotifier<HomepageState> {
  final StateNotifierProviderRef ref;
  HomepageNotifier(this.ref) : super(HomepageState.initial());

  var _currentOverview = CourseOverview.empty();

  Future<void> init([bool isUpdating = false]) async {
    state = const HomepageState.loading('Getting data...');
    final courseRepository = ref.read(coursesRepositoryProvider);
    try {
      final overview = await courseRepository.getUserCourseOverview();
      _currentOverview = overview;
      ref.read(gradeCompletedCountProvider.state).state =
          overview.generalInfo.completedLessons;
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
    //updating general info
    final completedLessons = ref.read(gradeCompletedCountProvider);
    final generalInfo = _currentOverview.generalInfo.copyWith(completedLessons);
    //updating continuing lesson
    final lesson = ref.read(currentLessonProvider);
    if (lesson.id == _currentOverview.currentLesson.id) {
      _currentOverview.currentLesson
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
    state = HomepageState.content(CourseOverview(
        generalInfo: generalInfo, currentLesson: lesson, topicList: topicList));
  }
}
