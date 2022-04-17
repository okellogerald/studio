
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/models/lesson.dart';

final lessonsIdsProvider = StateProvider<List<String>>((ref) => []);

final currentLessonProvider = StateProvider<Lesson>((ref) => const Lesson());