import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_state.freezed.dart';

@freezed
class VideoState with _$VideoState {
  const factory VideoState.initial() = _Initial;
  const factory VideoState.loading([String? message]) = _Loading;
  const factory VideoState.content() = _Content;
  const factory VideoState.error(String message) = _Error;
}
