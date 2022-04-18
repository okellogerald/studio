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
    state = const TopicPageState.loading('Getting lessons ...');
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

  List<SubTopic> _getFilteredSubTopics() {
    final filterType = ref.read(currentFilterProvider);
    if (filterType == LessonsFilter.all) return _subtopics;

    final subtopics = <SubTopic>[];
    for (var subtopic in _subtopics) {
      final lessons = subtopic.lessons;
      var filteredLessons = <Lesson>[];
      if (filterType == LessonsFilter.learn) {
        filteredLessons =
            lessons.where((e) => e.type == LessonType.learn).toList();
      }
      if (filterType == LessonsFilter.practice) {
        filteredLessons =
            lessons.where((e) => e.type == LessonType.practice).toList();
      }
      if (filterType == LessonsFilter.paid) {
        filteredLessons = lessons.where((e) => e.isPaid).toList();
      }
      if (filterType == LessonsFilter.free) {
        filteredLessons = lessons.where((e) => !e.isPaid).toList();
      }
      subtopics.add(SubTopic(topic: subtopic.topic, lessons: filteredLessons));
    }
    return subtopics;
  }
}
