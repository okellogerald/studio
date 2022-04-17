import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LessonsFilter { all, learn, practice, free, paid }

final currentFilterProvider =
    StateProvider<LessonsFilter>((ref) => LessonsFilter.all);

final currentTopicIdProvider = StateProvider<String>((ref) => '');

final topicCompletedCountProvider = StateProvider<int>((ref) => 0);
