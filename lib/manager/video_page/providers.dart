import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'models/video.dart';

enum OrientationMode { portrait, landscape }

enum PlayerState { playing, paused, end }

extension PlayerStateExtensio on PlayerState {
  bool get isPlaying => this == PlayerState.playing;
  bool get isPaused => this == PlayerState.paused;
  bool get isEnd => this == PlayerState.end;
}

final videoControllerProvider = StateProvider<VideoPlayerController>(
    (ref) => VideoPlayerController.network(''));

final qualityLabelProvider =
    StateProvider<QualityLabel>((ref) => QualityLabel.label720);

final videosProvider = StateProvider<List<Video>>((ref) => []);

final orintationModeProvider =
    StateProvider<OrientationMode>((ref) => OrientationMode.portrait);

final playerStateProvider =
    StateProvider<PlayerState>((ref) => PlayerState.playing);
