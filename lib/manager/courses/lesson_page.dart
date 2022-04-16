import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/repositories/source.dart';
import '../../errors/error_handler.dart';
import '../../models/lesson.dart';

final lessonProvider = FutureProvider.family<Lesson, String>((ref, id) async {
  final coursesRepository = ref.read(coursesRepositoryProvider);
  return coursesRepository
      .getLesson(id)
      .timeout(timeLimit)
      .catchError((error) => throw getErrorMessage(error));
});

final lessonsIdsProvider = StateProvider<List<String>>((ref) => []);
