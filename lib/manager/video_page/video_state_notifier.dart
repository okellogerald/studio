import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/video_page/providers.dart';
import 'package:video_player/video_player.dart';
import 'models/video.dart';
import 'models/video_state.dart';

final videoStateNotifierProvider =
    StateNotifierProvider<VideoStateNotifier, VideoState>(
        (ref) => VideoStateNotifier(ref));

class VideoStateNotifier extends StateNotifier<VideoState> {
  VideoStateNotifier(this.ref) : super(const VideoState.initial()) {
    init();
  }

  final StateNotifierProviderRef ref;

  Future<void> init([String? loadingMessage]) async {
    state = VideoState.loading(loadingMessage ?? 'Initializing...');
    final currentLabel = ref.read(qualityLabelProvider);
    final videos = ref.read(videosProvider);
    final index = videos.indexWhere((e) => e.label == currentLabel);
    final video = videos[index];
    final controller = VideoPlayerController.network(video.url);
    try {
      await controller.initialize();
      await controller.play();
      ref.read(videoControllerProvider.state).state = controller;
      ref.read(playerStateProvider.state).state = PlayerState.playing;
      state = const VideoState.content();
    } catch (error) {
      state = VideoState.error(error.toString());
    }
  }

  void changeQualityLabel(QualityLabel label) async {
    final currentLabel = ref.read(qualityLabelProvider);
    if (label == currentLabel) return;
    ref.read(qualityLabelProvider.state).state = label;
    await init('changing video quality');
  }

}
