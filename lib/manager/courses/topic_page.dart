import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/repositories/source.dart';
import '../../errors/error_handler.dart';
import '../../models/lesson.dart';
import 'lesson_page.dart';
import 'models/topic_data.dart';

final topicLessonsProvider =
    FutureProvider.family<TopicData, String>((ref, id) async {
  final coursesRepository = ref.read(coursesRepositoryProvider);
  final topicData = await coursesRepository
      .getTopicLessons(id)
      .timeout(timeLimit)
      .catchError((error) => throw getErrorMessage(error));
  ref.read(lessonsIdsProvider.state).state =
      topicData.lessons.where((e) => !e.isPaid).map((e) => e.id).toList();
  return topicData;
});

enum LessonsFilter { all, learn, practice, free, paid }

final currentFilterProvider =
    StateProvider<LessonsFilter>((ref) => LessonsFilter.all);

final topicCompletedCountProvider = StateProvider<int>((ref) => 0);

final filteredLessonsProvider =
    Provider.family<List<Lesson>, List<Lesson>>((ref, lessons) {
  final filterType = ref.watch(currentFilterProvider);
  switch (filterType) {
    case LessonsFilter.learn:
      return lessons.where((e) => e.type == LessonType.learn).toList();
    case LessonsFilter.practice:
      return lessons.where((e) => e.type == LessonType.practice).toList();
    case LessonsFilter.free:
      return lessons.where((e) => !e.isPaid).toList();
    case LessonsFilter.paid:
      return lessons.where((e) => e.isPaid).toList();
    default:
      return lessons;
  }
});

final subTopicsIdsProvider =
    Provider.family<List<String>, List<Lesson>>((ref, lessons) {
  final subTopicIds = <String>[];
  for (var lesson in lessons) {
    if (!subTopicIds.contains(lesson.topicId)) subTopicIds.add(lesson.topicId);
  }
  return subTopicIds;
});

void handleSelectedFilter(WidgetRef ref, int tabIndex) {
  switch (tabIndex) {
    case 0:
      ref.read(currentFilterProvider.state).state = LessonsFilter.all;
      break;
    case 1:
      ref.read(currentFilterProvider.state).state = LessonsFilter.learn;
      break;
    case 2:
      ref.read(currentFilterProvider.state).state = LessonsFilter.practice;
      break;
    case 3:
      ref.read(currentFilterProvider.state).state = LessonsFilter.free;
      break;
    case 4:
      ref.read(currentFilterProvider.state).state = LessonsFilter.paid;
      break;
    default:
  }
}
