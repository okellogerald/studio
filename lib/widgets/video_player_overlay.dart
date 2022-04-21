import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silla_studio/manager/video/providers.dart';
import 'app_divider.dart';
import 'app_icon_button.dart';
import 'app_text_button.dart';
import 'source.dart';
import 'package:silla_studio/widgets/video_action_controls.dart';
import '../manager/video/models/video.dart';
import '../manager/video/video_controls_actions_handler.dart';

class VideoPlayerOverlay extends ConsumerStatefulWidget {
  const VideoPlayerOverlay(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  ConsumerState<VideoPlayerOverlay> createState() => _VideoPlayerOverlayState();
}

class _VideoPlayerOverlayState extends ConsumerState<VideoPlayerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late final OverlayState overlayState;
  late final OverlayEntry overlayEntry;
  final tappedPositionNotifier = ValueNotifier<Offset>(Offset.zero);

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutCubic);
    controller.forward();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      overlayState = Overlay.of(context)!;
      overlayEntry = labelsOverlayEntry();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (overlayEntry.mounted) overlayEntry.remove();
        return true;
      },
      child: AnimatedBuilder(
          animation: animation,
          child: _buildGestureHandler(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                _buildTitle(),
                VideoActionControls(onLabelButtonTap: _handleLabelButtonTap),
              ])),
          builder: (context, child) {
            return animation.isCompleted ? _buildGestureHandler() : child!;
          }),
    );
  }

  Widget _buildTitle() {
    final orientationMode = ref.watch(orientationModeProvider);
    return orientationMode == Orientation.landscape
        ? Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 10.dh),
            color: AppColors.primary,
            child: Row(children: [
              AppIconButton(
                  onPressed: () {
                    handleVideoControlsActions(
                        ref, VideoControlAction.changeOrientation);
                  },
                  icon: FontAwesomeIcons.angleLeft,
                  margin: EdgeInsets.only(right: 15.dw),
                  iconThemeData:
                      IconThemeData(size: 25.dw, color: AppColors.onSecondary)),
              AppText(widget.title, size: 16.dw, color: AppColors.onSecondary)
            ]))
        : Container();
  }

  Widget _buildGestureHandler({Widget? child}) {
    return GestureDetector(
        onTapDown: (_) => _handleOnTapDown(),
        onTapUp: (_) => _handleOnTapUp(),
        child: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.white.withOpacity(.0),
            child: child));
  }

  void _handleOnTapUp() {
    controller.forward();
    handleStatusBarVisibility(ref);
  }

  void _handleOnTapDown() => controller.reset();

  _handleLabelButtonTap(Offset position) {
    tappedPositionNotifier.value = position;
    overlayState.insert(overlayEntry);
    controller.reset();
  }

  labelsOverlayEntry() {
    return OverlayEntry(
        builder: (_) => GestureDetector(
              onTap: () {
                overlayEntry.remove();
                controller.forward();
              },
              child: Container(
                  color: Colors.white.withOpacity(0.0),
                  child: Stack(children: [
                    ValueListenableBuilder<Offset>(
                        valueListenable: tappedPositionNotifier,
                        builder: (context, tappedPosition, snapshot) {
                          return Positioned(
                            top: tappedPosition.dy - 65.dh,
                            right: 35.dw,
                            child: _buildLabelsListView(),
                          );
                        })
                  ])),
            ));
  }

  Widget _buildLabelsListView() {
    final currentLabel = ref.watch(qualityLabelProvider);
    return Material(
        color: Colors.transparent,
        child: Container(
          height: 45.dh,
          padding: EdgeInsets.symmetric(horizontal: 10.dw),
          decoration: BoxDecoration(
              color: AppColors.onSecondary,
              borderRadius: BorderRadius.all(Radius.circular(20.dw))),
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: qualityLabels.length,
              separatorBuilder: (_, index) => AppDivider(
                  height: 50.dh, width: 1, color: Colors.grey.shade200),
              itemBuilder: (_, index) {
                final label = qualityLabels[index];
                return AppTextButton(
                  onPressed: () {
                    handleVideoControlsActions(
                        ref, VideoControlAction.changeQualityLabel,
                        label: label);
                    overlayEntry.remove();
                  },
                  padding: EdgeInsets.symmetric(horizontal: 10.dw),
                  text: label.labelName,
                  textStyle: TextStyle(
                      fontSize: 14.dw,
                      color: label == currentLabel
                          ? AppColors.accent
                          : AppColors.onBackground),
                );
              }),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
