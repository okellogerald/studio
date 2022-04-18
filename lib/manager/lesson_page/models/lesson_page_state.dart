import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_page_state.freezed.dart';

@freezed
class LessonPageState with _$LessonPageState {
  const factory LessonPageState.loading([String? message]) = _Loading;
  const factory LessonPageState.content() = _Content;
  const factory LessonPageState.failed(String message) = _Failed;

  factory LessonPageState.initial() => const LessonPageState.content();
}
