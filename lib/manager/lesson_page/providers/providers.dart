
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/lesson_page/models/lesson.dart';

final lessonsIdsProvider = StateProvider<List<String>>((ref) => []);

//should be updated every-time the lesson completion status is changed.
final currentLessonProvider = StateProvider<Lesson>((ref) => const Lesson());