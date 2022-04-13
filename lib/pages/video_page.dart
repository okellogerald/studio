import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/video_page/models/video_details.dart';
import 'package:silla_studio/manager/video_page/providers.dart';
import 'package:silla_studio/manager/video_page/video_state_notifier.dart';
import 'package:silla_studio/widgets/video_overlay.dart';
import 'package:video_player/video_player.dart';
import '../source.dart';

class VideoPage extends ConsumerStatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  ConsumerState<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends ConsumerState<VideoPage> {
  late VideoDetails videoDetails;

  @override
  void initState() {
    videoDetails = VideoDetails.fromJson(jsonVideoDetails['playlist'][0]);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(videosProvider.state).state = videoDetails.videos;
      ref.read(videoStateNotifierProvider.notifier).init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final videoState = ref.watch(videoStateNotifierProvider);

    return SafeArea(
        child: Scaffold(
            body: videoState.when(
      initial: () => Container(),
      loading: _buildLoading,
      content: () => _buildVideoPlayer(),
      error: _buildError,
    )));
  }

  Widget _buildLoading(String? message) {
    return AspectRatio(
        aspectRatio: 1.78,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                image:
                    DecorationImage(image: NetworkImage(videoDetails.image))),
            child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.dw, vertical: 15.dw),
                color: Colors.white,
                child: AppLoadingIndicator(message))));
  }

  Widget _buildError(String message) {
    return AspectRatio(
        aspectRatio: 1.78,
        child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15.dw),
            child: AppText(message,
                color: AppColors.error, alignment: TextAlign.center)));
  }

  Widget _buildVideoPlayer() {
    final controller = ref.watch(videoControllerProvider);
    return Center(
        child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(alignment: Alignment.bottomCenter, children: [
              VideoPlayer(controller),
              VideoPlayerOverlay(videoDetails.title)
            ])));
  }
}
