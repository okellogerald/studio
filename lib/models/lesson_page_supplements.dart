import '../source.dart';

part 'lesson_page_supplements.freezed.dart';

@freezed
class LessonPageSupplements with _$LessonPageSupplements {
  const LessonPageSupplements._();

  const factory LessonPageSupplements(
      {required Lesson lesson,
      required List<String> lessonsIdList,
      required int currentIndex,
      required int lessonsLength}) = _LessonPageSupplements;

  factory LessonPageSupplements.empty() => LessonPageSupplements(
      lesson: Lesson.empty(),
      currentIndex: 0,
      lessonsLength: 0,
      lessonsIdList: []);

  bool get isFirst => currentIndex == 0;
  bool get isLast => currentIndex == lessonsLength - 1;
}
