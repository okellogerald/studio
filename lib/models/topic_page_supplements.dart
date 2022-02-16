import '../source.dart';

part 'topic_page_supplements.freezed.dart';

enum FilterType { all, free, paid, practice, learn }

@freezed
class TopicPageSupplements with _$TopicPageSupplements {
  const factory TopicPageSupplements({
    required FilterType filterType,
    required List<Lesson> lessons,
    required List<Topic> topics,
  }) = _TopicPageSupplements;

  factory TopicPageSupplements.empty() =>
      const TopicPageSupplements(filterType: FilterType.all, topics: [], lessons: []);
}
