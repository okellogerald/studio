import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/topic_page/models/topic.dart';

enum LessonsFilter { all, learn, practice, free, paid, audio }

extension LessonFilterExtension on LessonsFilter {
  bool get isAll => this == LessonsFilter.all;
  bool get isLearn => this == LessonsFilter.learn;
  bool get isPractice => this == LessonsFilter.practice;
  bool get isFree => this == LessonsFilter.free;
  bool get isPaid => this == LessonsFilter.paid;
  bool get isAudio => this == LessonsFilter.audio;
}

final currentFilterProvider =
    StateProvider<LessonsFilter>((ref) => LessonsFilter.all);

//should be updated every-time the lesson completion status is changed.
final currentTopicProvider = StateProvider<Topic>((ref) => const Topic());
