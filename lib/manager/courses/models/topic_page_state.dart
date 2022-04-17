import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silla_studio/manager/courses/models/sub_topic.dart';

part 'topic_page_state.freezed.dart';

@freezed
class TopicPageState with _$TopicPageState {
  const factory TopicPageState.loading([String? message]) = _Loading;
  const factory TopicPageState.content(List<SubTopic> subtopics) = _Content;
  const factory TopicPageState.failed(String message) = _Failed;

  factory TopicPageState.initial() => const TopicPageState.content([]);
}
