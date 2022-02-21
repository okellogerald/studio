import '../source.dart';

part 'topic_page_supplements.freezed.dart';

enum FilterType { all, free, paid, practice, learn }

@freezed
class TopicPageSupplements with _$TopicPageSupplements {
  const TopicPageSupplements._();
  const factory TopicPageSupplements({
    required FilterType filterType,
    required List<Lesson> lessons,
    required List<Topic> topics,
    required int completedCount,
  }) = _TopicPageSupplements;

  factory TopicPageSupplements.empty() => const TopicPageSupplements(
      filterType: FilterType.all, topics: [], lessons: [], completedCount: 0);

  List<String> get getTopicsIdList {
    final idList = <String>[];
    for (Topic topic in topics) {
      idList.add(topic.id);
    }
    return idList;
  }
}
