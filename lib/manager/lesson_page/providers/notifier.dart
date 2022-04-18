import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/errors/source.dart';
import 'package:silla_studio/manager/courses_repository.dart';
import 'package:silla_studio/manager/lesson_page/models/lesson.dart';
import 'package:silla_studio/manager/lesson_page/models/lesson_page_state.dart';
import 'package:silla_studio/manager/lesson_page/providers/providers.dart';


final lessonPageNotifierProvider =
    StateNotifierProvider<LessonPageNotifier, LessonPageState>(
        (ref) => LessonPageNotifier(ref));

class LessonPageNotifier extends StateNotifier<LessonPageState> {
  final StateNotifierProviderRef ref;
  LessonPageNotifier(this.ref) : super(LessonPageState.initial());

  Future<void> init() async {
    state = const LessonPageState.loading('Fetching lesson data...');
    final coursesRepository = ref.read(coursesRepositoryProvider);
    final lesson = ref.read(currentLessonProvider);
    try {
      final _lesson =
          await coursesRepository.getLesson(lesson.id).timeout(timeLimit);
      state = LessonPageState.content(_lesson);
    } catch (error) {
      final message = getErrorMessage(error);
      state = LessonPageState.failed(message);
    }
  }

  Future<void> markLessonAs() async {
    final lesson = ref.read(currentLessonProvider);
    final status = lesson.isComplete ? Status.incomplete : Status.completed;
    state =
        LessonPageState.loading('Marking ${lesson.title} as ${status.value}');
    final coursesRepository = ref.read(coursesRepositoryProvider);
    try {
      final updatedLesson = await coursesRepository
          .updateLessonStatus(status.value, lesson.id)
          .timeout(timeLimit);
      ref.read(currentLessonProvider.state).state = updatedLesson;
      log('reached here');
      state = LessonPageState.content(updatedLesson);
    } catch (error) {
      final message = getErrorMessage(error);
      state = LessonPageState.failed(message);
    }
  }
}
