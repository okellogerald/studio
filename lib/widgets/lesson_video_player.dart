import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/video/providers.dart';
import 'package:silla_studio/manager/video/video_state_notifier.dart';
import 'package:silla_studio/utils/utils.dart';
import 'package:silla_studio/widgets/app_image.dart';
import 'package:silla_studio/widgets/video_player_overlay.dart';
import 'package:video_player/video_player.dart';
import '../manager/video/models/video_details.dart';
import '../manager/video/video_controls_actions_handler.dart';
import '../source.dart';

class LessonVideoPlayer extends ConsumerStatefulWidget {
  const LessonVideoPlayer({Key? key}) : super(key: key);

  @override
  ConsumerState<LessonVideoPlayer> createState() => _LessonVideoPlayerState();
}

class _LessonVideoPlayerState extends ConsumerState<LessonVideoPlayer> {
  late VideoDetails videoDetails;

  @override
  void initState() {
    videoDetails = VideoDetails.fromJson(jsonVideoDetails['playlist'][0]);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(videosProvider.state).state = videoDetails.videos;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final videoState = ref.watch(videoStateNotifierProvider);

    return WillPopScope(
      onWillPop: () async {
        handleVideoControllerOnPop(ref);
        return true;
      },
      child: videoState.when(
        initial: _buildInitial,
        loading: _buildLoading,
        content: _buildVideoPlayer,
        error: _buildError,
      ),
    );
  }

  Widget _buildInitial() {
    final videoLength = Utils.convertFrom(videoDetails.duration * 1000);
    return Stack(alignment: Alignment.bottomCenter, children: [
      AppImage(
          imageUrl: videoDetails.image,
          height: 220.dh,
          width: ScreenSizeConfig.getFullWidth),
      Container(
        height: 40.dh,
        width: ScreenSizeConfig.getFullWidth,
        padding: EdgeInsets.symmetric(horizontal: 15.dw),
        color: AppColors.secondary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(videoLength, color: AppColors.onSecondary),
            AppTextButton(
                text: 'Play',
                height: 30.dh,
                padding: EdgeInsets.symmetric(horizontal: 30.dw),
                onPressed: ref.read(videoStateNotifierProvider.notifier).init,
                textColor: AppColors.primary,
                borderRadius: 15.dw,
                backgroundColor: AppColors.onSecondary),
          ],
        ),
      ),
    ]);
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
