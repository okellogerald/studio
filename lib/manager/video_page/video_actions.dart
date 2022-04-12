import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/video_page/providers.dart';

enum VideoControlAction { pause, resume, replay }

void handleVideoControlsActions(
    WidgetRef ref, VideoControlAction action) async {
  if (action == VideoControlAction.pause) {
    final controller = ref.read(videoControllerProvider);
    await controller.pause();
    ref.read(playerStateProvider.state).state = PlayerState.paused;
  }
  if (action == VideoControlAction.resume) {
    final controller = ref.read(videoControllerProvider);
    await controller.play();
    ref.read(playerStateProvider.state).state = PlayerState.playing;
  }
  if (action == VideoControlAction.replay) {
    final controller = ref.read(videoControllerProvider);
    await controller.seekTo(Duration.zero);
    await controller.play();
    ref.read(playerStateProvider.state).state = PlayerState.playing;
  }
}
