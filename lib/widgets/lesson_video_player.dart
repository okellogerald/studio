import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silla_studio/manager/video/providers.dart';
import 'package:silla_studio/manager/video/video_state_notifier.dart';
import 'package:silla_studio/utils/utils.dart';
import 'package:silla_studio/widgets/app_image.dart';
import 'package:silla_studio/widgets/video_player_overlay.dart';
import 'package:video_player/video_player.dart';
import '../manager/video/models/video_details.dart';
import 'app_icon_button.dart';
import 'app_loading_indicator.dart';
import 'source.dart';

class LessonVideoPlayer extends ConsumerStatefulWidget {
  const LessonVideoPlayer(this.videoDetails, {Key? key}) : super(key: key);

  final VideoDetails videoDetails;

  @override
  ConsumerState<LessonVideoPlayer> createState() => _LessonVideoPlayerState();
}

class _LessonVideoPlayerState extends ConsumerState<LessonVideoPlayer> {
  late VideoDetails videoDetails;

  @override
  void initState() {
    videoDetails = widget.videoDetails;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(videosProvider.state).state = videoDetails.videos;
      ref.read(videoStateNotifierProvider.notifier).init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final videoState = ref.watch(videoStateNotifierProvider);

    return videoState.when(
      initial: _buildInitial,
      loading: _buildLoading,
      content: _buildVideoPlayer,
      error: _buildError,
    );
  }

  Widget _buildInitial() {
    return Container(
      width: ScreenSizeConfig.getFullWidth,
      height: 220.dh,
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: NetworkImage(videoDetails.image), fit: BoxFit.cover)),
      alignment: Alignment.center,
      child: AppIconButton(
          onPressed: ref.read(videoStateNotifierProvider.notifier).play,
          icon: FontAwesomeIcons.circlePlay,
          iconThemeData:
              IconThemeData(size: 60.dw, color: AppColors.primary)),
    );
  }

  Widget _buildLoading(String? message) {
    final size = ref.watch(videoSizeConfigsProvider);

    return Center(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                image:
                    DecorationImage(image: NetworkImage(videoDetails.image))),
            child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.dw, vertical: 15.dw),
                color: Colors.white,
                child: AppLoadingIndicator(message))),
      ),
    );
  }

  Widget _buildError(String message) {
    final size = ref.watch(videoSizeConfigsProvider);

    return Center(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15.dw),
            child: AppText(message,
                color: AppColors.error, alignment: TextAlign.center)),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    final controller = ref.watch(videoControllerProvider);
    final size = ref.watch(videoSizeConfigsProvider);
    return Center(
        child: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(alignment: Alignment.bottomCenter, children: [
              VideoPlayer(controller),
              VideoPlayerOverlay(videoDetails.title)
            ])));
  }
}
