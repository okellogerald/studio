import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/video_page/models/video_details.dart';
import 'package:silla_studio/manager/video_page/providers.dart';
import 'package:silla_studio/manager/video_page/video_actions.dart';
import 'package:silla_studio/manager/video_page/video_state_notifier.dart';
import 'package:video_player/video_player.dart';
import '../source.dart';
import '../widgets/app_slider.dart';

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

    return Scaffold(
      body: videoState.when(
          initial: () => Container(),
          loading: (message) => Container(
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: NetworkImage(videoDetails.image))),
              child: AppLoadingIndicator(message)),
          content: () => _buildVideoPlayer(),
          error: (message) =>
              Container(color: Colors.white, child: AppText(message))),
    );
  }

  Widget _buildVideoPlayer() {
    final controller = ref.watch(videoControllerProvider);
    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [VideoPlayer(controller), _buildVideoControls()],
        ));
  }

  Widget _buildVideoControls() {
    return Container(
      height: 50.dh,
      margin: EdgeInsets.fromLTRB(6.dw, 0, 6.dw, 6.dh),
      padding: EdgeInsets.symmetric(horizontal: 15.dw),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.dw))),
      child: Column(
        children: [
          _buildSliderLine(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            AppText('2:22 / 5:22', size: 14.dw),
            _buildPlayerStateTextButton(),
            AppIconButton(onPressed: () {}, icon: EvaIcons.expand)
          ]),
        ],
      ),
    );
  }

  Widget _buildPlayerStateTextButton() {
    final playerState = ref.watch(playerStateProvider);
    return Expanded(
      child: SizedBox(
        width: 100.dw,
        child: AppIconButton(
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
            icon: playerState.isPlaying
                ? EvaIcons.pauseCircle
                : playerState.isPaused
                    ? EvaIcons.playCircle
                    : EvaIcons.playCircle),
      ),
    );
  }

  _buildSliderLine() {
    final controller = ref.watch(videoControllerProvider);
    final currentPosition = controller.value.position;
    final bufferedPosition = controller.value.buffered;
    print(bufferedPosition);
    final duration = controller.value.duration;

    return AppSlider(
        currentValue: currentPosition.inMilliseconds,
        bufferedValue: 4545,
        duration: duration.inMilliseconds,
        sliderWidth: 360.dw,
        onValueChanged: (_) {
          print(_);
        });
  }
}
