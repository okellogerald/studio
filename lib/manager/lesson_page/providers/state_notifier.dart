import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/errors/source.dart';
import 'package:silla_studio/manager/courses_repository.dart';
import 'package:silla_studio/manager/homepage/providers.dart';
import 'package:silla_studio/manager/lesson_page/models/lesson.dart';
import 'package:silla_studio/manager/lesson_page/models/lesson_page_state.dart';
import 'package:silla_studio/manager/lesson_page/providers/providers.dart';
import 'package:silla_studio/manager/topic_page/providers/state_notifier.dart';

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
      ref.read(currentLessonProvider.state).state = _lesson;
      state = const LessonPageState.content();
    } catch (error) {
      _handleError(error);
    }
  }

  Future<void> changeLessonCompletionStatus() async {
    final lesson = ref.read(currentLessonProvider);
    final status = lesson.isComplete ? Status.incomplete : Status.completed;
    state =
        LessonPageState.loading('Marking ${lesson.title} as ${status.value}');
    final coursesRepository = ref.read(coursesRepositoryProvider);
    try {
      await coursesRepository
          .updateLessonStatus(status.value, lesson.id)
          .timeout(timeLimit);

      ///updating lesson completion status
      ref.read(currentLessonProvider.state).state = lesson.copyWith(
          completionStatus:
              lesson.isComplete ? Status.incomplete : Status.completed);

      ///updating topic-page : should start before homepage update
      ref.read(topicPageNotifierProvider.notifier).update();

      ///updating homepage
      ref.read(homepageNotifierProvider.notifier).update();
      state = const LessonPageState.content();
    } catch (error) {
      _handleError(error);
    }
  }

  Future<void> goToNext() => _changeLesson(true);

  Future<void> goToPrev() => _changeLesson(false);

  Future<void> _changeLesson(bool isNext) async {
    state = LessonPageState.loading(
        'fetching ${isNext ? 'next' : 'previous'} lesson...');

    final lesson = ref.read(currentLessonProvider);
    final coursesRepository = ref.read(coursesRepositoryProvider);

    final lessonsIdList = ref.read(lessonsIdsProvider);
    final index = lessonsIdList.indexOf(lesson.id);
    if (index == -1) throw 'lesson id not found';

    final nextLessonId = lessonsIdList[(isNext ? index + 1 : index - 1)];

    try {
      final nextLesson =
          await coursesRepository.getLesson(nextLessonId).timeout(timeLimit);
      ref.read(currentLessonProvider.state).state = nextLesson;
      state = const LessonPageState.content();
    } catch (error) {
      _handleError(error);
    }
  }

  _handleError(var error) {
    log('$error');
    final message = getErrorMessage(error);
    state = LessonPageState.failed(message);
  }
}
