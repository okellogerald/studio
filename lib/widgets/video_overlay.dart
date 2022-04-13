import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/video_page/providers.dart';
import 'package:silla_studio/source.dart';
import 'package:silla_studio/widgets/video_action_controls.dart';

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

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child: _buildGestureHandler(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              _buildTitle(),
              const VideoActionControls(),
            ])),
        builder: (context, child) {
          return animation.isCompleted ? _buildGestureHandler() : child!;
        });
  }

  Widget _buildTitle() {
    final orientationMode = ref.watch(orientationModeProvider);
    return orientationMode == Orientation.landscape
        ? Container(
            padding: EdgeInsets.fromLTRB(15.dw, 15.dw, 15.dw, 0),
            color: Colors.black,
            child: AppText(widget.title,
                size: 16.dw, color: AppColors.onSecondary))
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

  void _handleOnTapUp() => controller.forward();

  void _handleOnTapDown() => controller.reset();
}
