import '../errors/app_error.dart';
import '../source.dart';

part 'lesson_page_state.freezed.dart';


@freezed
class LessonPageState with _$LessonPageState {
  const factory LessonPageState.loading(LessonPageSupplements supplements, {String? message}) = _Loading;
  const factory LessonPageState.content(LessonPageSupplements supplements) = _Content;
  const factory LessonPageState.failed(LessonPageSupplements supplements,  AppError error) = _Failed;

  factory LessonPageState.initial() => LessonPageState.content(LessonPageSupplements.empty());
}
