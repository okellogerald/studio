import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/video/providers.dart';
import 'package:silla_studio/manager/video/video_controls_actions_handler.dart';
import 'package:video_player/video_player.dart';

import 'models/video.dart';
import 'models/video_state.dart';

final videoStateNotifierProvider =
    StateNotifierProvider<VideoStateNotifier, VideoState>(
        (ref) => VideoStateNotifier(ref));

class VideoStateNotifier extends StateNotifier<VideoState> {
  VideoStateNotifier(this.ref) : super(const VideoState.initial());

  final StateNotifierProviderRef ref;

  void init() => state = const VideoState.initial();

  Future<void> play() async {
    state = const VideoState.loading('Initializing...');
    final currentLabel = ref.read(qualityLabelProvider);
    final videos = ref.read(videosProvider);
    final index = videos.indexWhere((e) => e.label == currentLabel);
    final video = videos[index];
    final controller = VideoPlayerController.network(video.url);
    try {
      await controller.initialize();
      await controller.play();
      initVideoPositionHandler(ref);
      ref.read(videoControllerProvider.state).state = controller;
      ref.read(playerStateProvider.state).state = PlayerState.playing;
      state = const VideoState.content();
    } catch (error) {
      state = VideoState.error(error.toString());
    }
  }

  void changeQualityLabelTo(QualityLabel label) async {
    final currentLabel = ref.read(qualityLabelProvider);
    if (label == currentLabel) return;

    state = const VideoState.loading('Changing video quality...');
    final controller = ref.read(videoControllerProvider);
    await controller.pause();

    final videos = ref.read(videosProvider);
    final index = videos.indexWhere((e) => e.label == label);
    final video = videos[index];
    final newController = VideoPlayerController.network(video.url);
    try {
      await newController.initialize();
      //continuing right where it was.
      final currentPosition = ref.read(positionProvider);
      await newController.seekTo(Duration(milliseconds: currentPosition));
      await newController.play();
      //starting the position timer
      initVideoPositionHandler(ref);
      //updating states
      ref.read(videoControllerProvider.state).state = newController;
      ref.read(playerStateProvider.state).state = PlayerState.playing;
      ref.read(qualityLabelProvider.state).state = label;
      state = const VideoState.content();
    } catch (error) {
      state = VideoState.error(error.toString());
    }
  }

  void changeVideoPosition(int position) async {
    state = const VideoState.loading('seeking position...');
    final controller = ref.read(videoControllerProvider);
    try {
      await controller.pause();
      await controller.seekTo(Duration(milliseconds: position));
      await controller.play();
      ref.read(positionProvider.state).state = position;
      ref.read(playerStateProvider.state).state = PlayerState.playing;
      state = const VideoState.content();
    } catch (error) {
      state = VideoState.error(error.toString());
    }
  }
}
