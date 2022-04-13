import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/video_page/models/video.dart';

import '../manager/video_page/providers.dart';
import '../manager/video_page/video_controls_actions_handler.dart';
import '../source.dart';
import '../utils/utils.dart';
import 'app_slider.dart';

class VideoActionControls extends ConsumerStatefulWidget {
  const VideoActionControls({Key? key}) : super(key: key);

  @override
  ConsumerState<VideoActionControls> createState() =>
      _VideoActionControlsState();
}

class _VideoActionControlsState extends ConsumerState<VideoActionControls> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSizeConfig.getFullWidth,
      height: 60.dh,
      child: Stack(alignment: Alignment.topCenter, children: [
        _buildControls(),
        _buildSliderLine(),
      ]),
    );
  }

  _buildControls() {
    return Positioned(
        top: 6.dh,
        child: Container(
            height: 50.dh,
            width: 400.dw,
            margin: EdgeInsets.fromLTRB(6.dw, 0, 6.dw, 6.dh),
            padding: EdgeInsets.symmetric(horizontal: 10.dw),
            alignment: Alignment.center,
            color: Colors.white,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _buildSliderLabels(),
                _buildPlayerStateIconButton(),
                _buildOtherVideoControls()
              ])
            ])));
  }

  _buildSliderLabels() {
    final duration = ref.watch(videoControllerProvider).value.duration;
    final position = ref.watch(positionProvider);
    final formattedDuration = Utils.convertFrom(duration.inMilliseconds, true);
    final formattedPosition = Utils.convertFrom(position, true);

    return Expanded(
        child: Container(
            alignment: Alignment.centerLeft,
            child: AppText('$formattedPosition / $formattedDuration',
                size: 14.dw)));
  }

  Widget _buildPlayerStateIconButton() {
    final playerState = ref.watch(playerStateProvider);
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: AppMaterialButton(
            onPressed: () {
              if (playerState.isPlaying) {
                handleVideoControlsActions(ref, VideoControlAction.pause);
              }
              if (playerState.isPaused) {
                handleVideoControlsActions(ref, VideoControlAction.resume);
              }
              if (playerState.isEnd) {
                handleVideoControlsActions(ref, VideoControlAction.replay);
              }
            },
            height: 38.dh,
            width: 50.dw,
            backgroundColor: AppColors.secondary,
            child: Icon(playerState.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 22.dw, color: AppColors.accent)),
      ),
    );
  }

  _buildSliderLine() {
    final duration = ref.watch(videoControllerProvider).value.duration;
    final position = ref.watch(positionProvider);
    return AppSlider(
        currentValue: position,
        bufferedValue: 4545,
        duration: duration.inMilliseconds,
        sliderWidth: 380.dw,
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
              ? EvaIcons.expand
              : EvaIcons.cast,
          margin: EdgeInsets.only(left: 10.dw),
          iconThemeData: IconThemeData(size: 18.dw, color: AppColors.secondary))
    ]));
  }

  _buildVideoQualityLabel() {
    final label = ref.watch(qualityLabelProvider);
    return DropdownButton<QualityLabel>(
        value: label,
        items: qualityLabels
            .map((e) => DropdownMenuItem<QualityLabel>(
                value: e, child: AppText(e.labelName, size: 14.dw)))
            .toList(),
        onChanged: (label) => handleVideoControlsActions(
            ref, VideoControlAction.changeQualityLabel,
            label: label));
  }
}
