import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/utils/screen_size_config.dart';
import 'package:video_player/video_player.dart';
import 'models/video.dart';

enum PlayerState { initial, playing, paused, end }

extension PlayerStateExtension on PlayerState {
  bool get isPlaying => this == PlayerState.playing;
  bool get isPaused => this == PlayerState.paused;
  bool get isEnd => this == PlayerState.end;
}

final videoControllerProvider = StateProvider<VideoPlayerController>(
    (ref) => VideoPlayerController.network(''));

final qualityLabelProvider =
    StateProvider<QualityLabel>((ref) => QualityLabel.label720);

final videosProvider = StateProvider<List<Video>>((ref) => []);

final orientationModeProvider =
    StateProvider<Orientation>((ref) => Orientation.portrait);

final playerStateProvider =
    StateProvider<PlayerState>((ref) => PlayerState.initial);

final positionProvider = StateProvider<int>((ref) => 0);

final videoSizeConfigsProvider = Provider<Size>((ref) {
  final orientation = ref.watch(orientationModeProvider);
  final label = ref.watch(qualityLabelProvider);
  final videos = ref.read(videosProvider);
  final video = videos.where((element) => element.label == label).first;

  final screenSize = Size(ScreenSizeConfig.sWidth, ScreenSizeConfig.sHeight);

  if (orientation == Orientation.portrait) {
    return Size(screenSize.width, screenSize.width / video.aspectRatio);
  } else {
    return Size(screenSize.width * video.aspectRatio, screenSize.width);
  }
});
