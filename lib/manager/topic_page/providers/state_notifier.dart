import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/courses_repository.dart';
import 'package:silla_studio/manager/lesson_page/models/lesson.dart';
import 'package:silla_studio/manager/lesson_page/providers/providers.dart';
import 'package:silla_studio/manager/topic_page/providers/providers.dart';
import '../../../errors/error_handler.dart';
import '../models/sub_topic.dart';
import '../models/topic_page_state.dart';

final topicPageNotifierProvider =
    StateNotifierProvider<TopicPageNotifier, TopicPageState>(
        (ref) => TopicPageNotifier(ref));

class TopicPageNotifier extends StateNotifier<TopicPageState> {
  final StateNotifierProviderRef ref;
  TopicPageNotifier(this.ref) : super(TopicPageState.initial());

  var _subtopics = <SubTopic>[];

  Future<void> init() async {
    state = const TopicPageState.loading('Getting topic content ...');
    final coursesRepository = ref.read(coursesRepositoryProvider);
    final topicId = ref.read(currentTopicProvider).id;
    try {
      _subtopics.clear();
      _subtopics =
          await coursesRepository.getSubTopics(topicId).timeout(timeLimit);

      final lessons = <Lesson>[];
      for (var subtopic in _subtopics) {
        lessons.addAll(subtopic.lessons);
      }
      final lessonsIdList =
          lessons.where((e) => !e.isPaid).map((e) => e.id).toList();
      ref.read(lessonsIdsProvider.state).state = lessonsIdList;

      state = TopicPageState.content(_subtopics);
    } catch (error) {
      final message = getErrorMessage(error);
      state = TopicPageState.failed(message);
    }
  }

  void filter() {
    final filteredSubTopics = _getFilteredSubTopics();
    state = TopicPageState.content(filteredSubTopics);
  }

  void update() {
    state = const TopicPageState.loading();
    //lesson after being updated
    final lesson = ref.read(currentLessonProvider);
    final topic = ref.read(currentTopicProvider);
    final updatedTopic = topic.copyWith(
        completedLessons: lesson.isComplete
            ? topic.completedLessons + 1
            : topic.completedLessons - 1);
    ref.read(currentTopicProvider.state).state = updatedTopic;
    //updating the lesson in the subtopics
    final index = _subtopics.indexWhere((e) => e.topic.id == lesson.topicId);
    final lessons = List<Lesson>.from(_subtopics[index].lessons);
    final lessonIndex = lessons.indexWhere((e) => e.id == lesson.id);
    lessons[lessonIndex] = lesson;

    final oldSubtopic = _subtopics[index];
    _subtopics[index] = SubTopic(topic: oldSubtopic.topic, lessons: lessons);
    //applying any filters
    filter();
  }

  List<SubTopic> _getFilteredSubTopics() {
    final filterType = ref.read(currentFilterProvider);
    if (filterType == LessonsFilter.all) return _subtopics;

    final subtopics = <SubTopic>[];
    for (var subtopic in _subtopics) {
      final lessons = subtopic.lessons;
      var filteredLessons = <Lesson>[];
      if (filterType.isLearn) {
        filteredLessons = lessons.where((e) => e.type.isLearn).toList();
      } else if (filterType.isPractice) {
        filteredLessons = lessons.where((e) => e.type.isPractice).toList();
      } else if (filterType.isPaid) {
        filteredLessons = lessons.where((e) => e.isPaid).toList();
      } else if (filterType.isFree) {
        filteredLessons = lessons.where((e) => !e.isPaid).toList();
      } else {
        filteredLessons = lessons.where((e) => e.type.isAudio).toList();
      }
      if (filteredLessons.isNotEmpty) {
        subtopics
            .add(SubTopic(topic: subtopic.topic, lessons: filteredLessons));
      }
    }
    return subtopics;
  }
}
