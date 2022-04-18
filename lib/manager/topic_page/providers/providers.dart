import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/topic_page/models/topic.dart';

enum LessonsFilter { all, learn, practice, free, paid }

final currentFilterProvider =
    StateProvider<LessonsFilter>((ref) => LessonsFilter.all);

//should be updated every-time the lesson completion status is changed.
final currentTopicProvider = StateProvider<Topic>((ref) => const Topic());
