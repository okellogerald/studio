import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/video/providers.dart';
import 'package:silla_studio/manager/video/video_state_notifier.dart';
import 'package:video_player/video_player.dart';
import 'models/video.dart';

enum VideoControlAction {
  pause,
  resume,
  replay,
  changeOrientation,
  changeQualityLabel,
  changePosition
}

void handleVideoControlsActions(WidgetRef ref, VideoControlAction action,
    {QualityLabel? label, int? position}) async {
  final videoStateNotifier = ref.read(videoStateNotifierProvider.notifier);
  final controller = ref.read(videoControllerProvider);

  if (action == VideoControlAction.pause) {
    await controller.pause();
    ref.read(playerStateProvider.state).state = PlayerState.paused;
  }
  if (action == VideoControlAction.resume) {
    await controller.play();
    ref.read(playerStateProvider.state).state = PlayerState.playing;
  }
  if (action == VideoControlAction.replay) {
    await controller.seekTo(Duration.zero);
    await controller.play();
    ref.read(positionProvider.state).state = 0;
    ref.read(playerStateProvider.state).state = PlayerState.playing;
    initVideoPositionHandler(ref);
  }
  if (action == VideoControlAction.changeOrientation) {
    final orientation = ref.read(orientationModeProvider);
    if (orientation == Orientation.landscape) {
      ref.read(orientationModeProvider.state).state = Orientation.portrait;
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    } else {
      ref.read(orientationModeProvider.state).state = Orientation.landscape;
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    }
  }
  if (action == VideoControlAction.changeQualityLabel) {
    videoStateNotifier.changeQualityLabelTo(label!);
  }
  if (action == VideoControlAction.changePosition) {
    videoStateNotifier.changeVideoPosition(position!);
  }
}

late Timer _timer;

void initVideoPositionHandler(var ref) {
  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    final playerState = ref.read(playerStateProvider) as PlayerState;
    if (playerState.isEnd || playerState.isPaused) return;

    final position = ref.read(positionProvider) as int;
    final controller =
        ref.read(videoControllerProvider) as VideoPlayerController;
    final duration = controller.value.duration.inMilliseconds;
    if (position == duration) {
      ref.read(positionProvider.state).state = duration;
      ref.read(playerStateProvider.state).state = PlayerState.end;
      return;
    }
    ref.read(positionProvider.state).state =
        controller.value.position.inMilliseconds;
  });
}

void disposeTimer() => _timer.cancel();

void initOrientationMode(WidgetRef ref, Orientation orientation) {
  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    ref.read(orientationModeProvider.state).state = orientation;
    if (orientation == Orientation.landscape) _handleLandscapeOrientation();
  });
}

///if orientation is [landscape], the status bar is hidden.
void handleStatusBarVisibility(WidgetRef ref) {
  final orientation = ref.read(orientationModeProvider);
  if (orientation == Orientation.landscape) _handleLandscapeOrientation();
}

void handleVideoControllerOnPop(WidgetRef ref) async {
  ref.read(playerStateProvider.state).state = PlayerState.initial;
  final controller = ref.read(videoControllerProvider);
  await controller.dispose();
  disposeTimer();
  ref.read(videoControllerProvider.state).state =
      VideoPlayerController.network('');
  final orientation = ref.read(orientationModeProvider);
  if (orientation == Orientation.landscape) {
    ref.read(orientationModeProvider.state).state = Orientation.portrait;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}

_handleLandscapeOrientation() =>
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
        overlays: [SystemUiOverlay.top]);
