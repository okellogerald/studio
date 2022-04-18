import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silla_studio/manager/video/models/video.dart';

import '../manager/video/providers.dart';
import '../manager/video/video_controls_actions_handler.dart';
import 'app_icon_button.dart';
import 'app_text_button.dart';
import 'source.dart';
import '../utils/utils.dart';
import 'video_position_slider.dart';

class VideoActionControls extends ConsumerStatefulWidget {
  const VideoActionControls({Key? key, required this.onLabelButtonTap})
      : super(key: key);

  final ValueChanged<Offset> onLabelButtonTap;

  @override
  ConsumerState<VideoActionControls> createState() =>
      _VideoActionControlsState();
}

class _VideoActionControlsState extends ConsumerState<VideoActionControls> {
  final labelButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = ref.watch(videoSizeConfigsProvider);
    return SizedBox(
        width: size.width,
        height: 55.dh,
        child: Stack(alignment: Alignment.topCenter, children: [
          _buildControls(),
          _buildSliderLine(),
        ]));
  }

  _buildControls() {
    final size = ref.watch(videoSizeConfigsProvider);
    return Positioned(
        top: 6.dh,
        child: Container(
            height: 55.dh,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 10.dw),
            alignment: Alignment.center,
            color: AppColors.secondary,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _buildPlayPauseButton(),
                _buildPositionLabels(),
                _buildOtherVideoControls(),
              ])
            ])));
  }

  _buildPositionLabels() {
    final duration = ref.watch(videoControllerProvider).value.duration;
    final position = ref.watch(positionProvider);
    final formattedDuration = Utils.convertFrom(duration.inMilliseconds, true);
    final formattedPosition = Utils.convertFrom(position, true);

    return Container(
        alignment: Alignment.centerLeft,
        child: AppText('$formattedPosition / $formattedDuration',
            size: 14.dw, color: AppColors.onSecondary));
  }

  _buildSliderLine() {
    final duration = ref.watch(videoControllerProvider).value.duration;
    final position = ref.watch(positionProvider);
    final size = ref.watch(videoSizeConfigsProvider);
    return AppSlider(
        currentValue: position,
        bufferedValue: 4545,
        duration: duration.inMilliseconds,
        sliderWidth: size.width,
        onValueChanged: (position) => handleVideoControlsActions(
            ref, VideoControlAction.changePosition,
            position: position));
  }

  _buildOtherVideoControls() {
    final orientation = ref.watch(orientationModeProvider);
    return Expanded(
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      _buildVideoQualityLabel(),
      AppIconButton(
          onPressed: () => handleVideoControlsActions(
              ref, VideoControlAction.changeOrientation),
          icon: orientation == Orientation.portrait
              ? FontAwesomeIcons.expand
              : FontAwesomeIcons.compress,
          margin: EdgeInsets.only(left: 25.dw, right: 5.dw),
          iconThemeData:
              IconThemeData(size: 18.dw, color: AppColors.onSecondary))
    ]));
  }

  _buildVideoQualityLabel() {
    final label = ref.watch(qualityLabelProvider);
    return AppTextButton(
        key: labelButtonKey,
        text: label.labelName,
        padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 5.dh),
        borderRadius: 5.dw,
        backgroundColor: AppColors.onSecondary,
        textStyle: TextStyle(color: AppColors.onBackground, fontSize: 14.dw),
        onPressed: () {
          final renderBox =
              labelButtonKey.currentContext!.findRenderObject() as RenderBox;
          final position = renderBox.localToGlobal(Offset.zero);
          widget.onLabelButtonTap(position);
        });
  }

  Widget _buildPlayPauseButton() {
    final playerState = ref.watch(playerStateProvider);
    return AppIconButton(
        onPressed: () => _handlePlayPauseButtonTap(playerState),
        margin: EdgeInsets.only(right: 15.dw),
        iconThemeData: IconThemeData(size: 25.dw, color: AppColors.onSecondary),
        icon: playerState.isPlaying
            ? FontAwesomeIcons.pause
            : FontAwesomeIcons.play);
  }

  void _handlePlayPauseButtonTap(PlayerState playerState) {
    if (playerState.isPlaying) {
      handleVideoControlsActions(ref, VideoControlAction.pause);
    } else if (playerState.isPaused) {
      handleVideoControlsActions(ref, VideoControlAction.resume);
    } else {
      handleVideoControlsActions(ref, VideoControlAction.replay);
    }
  }
}
