import '../source.dart';

part 'homepage_supplements.freezed.dart';

@freezed
class HomepageSupplements with _$HomepageSupplements {
  const factory HomepageSupplements({
    required Lesson lesson,
    required List<Topic> topicList,
    required GeneralInfo generalInfo,
    required Map userData,
  }) = _HomepageSupplements;

  factory HomepageSupplements.empty() => HomepageSupplements(
      lesson: Lesson.empty(),
      topicList: [],
      generalInfo: GeneralInfo.empty(),
      userData: {});
}
