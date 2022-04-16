import 'package:silla_studio/errors/app_error.dart';

import '../source.dart';

part 'topic_page_state.freezed.dart';

@freezed
class TopicPageState with _$TopicPageState {
  const factory TopicPageState.loading(TopicPageSupplements supplements, {String? message}) = _Loading;
  const factory TopicPageState.content(TopicPageSupplements supplements) = _Content;
  const factory TopicPageState.failed(TopicPageSupplements supplements, AppError error) = _Failed;

   factory TopicPageState.initial() => TopicPageState.content(TopicPageSupplements.empty());
}
