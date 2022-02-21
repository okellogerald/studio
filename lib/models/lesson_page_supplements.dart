import '../source.dart';

part 'lesson_page_supplements.freezed.dart';

@freezed
class LessonPageSupplements with _$LessonPageSupplements {
  const factory LessonPageSupplements({required Lesson lesson, required bool isLast}) = _LessonPageSupplements;

  factory LessonPageSupplements.empty() => LessonPageSupplements(lesson: Lesson.empty(), isLast: false);
}
