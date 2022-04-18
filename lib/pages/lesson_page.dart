import 'package:silla_studio/manager/user_action.dart';
import 'package:silla_studio/manager/video/providers.dart';
import '../manager/lesson_page/models/lesson.dart';
import '../manager/lesson_page/models/lesson_page_state.dart';
import '../manager/lesson_page/providers/notifier.dart';
import '../manager/lesson_page/providers/providers.dart';
import '../manager/video/providers.dart';
import '../widgets/app_divider.dart';
import '../widgets/check_mark.dart';
import '../widgets/failed_state_widget.dart';
import '../widgets/html_parser.dart';
import '../widgets/lesson_video_player.dart';
import 'source.dart';

class LessonPage extends ConsumerStatefulWidget {
  const LessonPage(this.lesson, {Key? key}) : super(key: key);

  final Lesson lesson;

  @override
  ConsumerState<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends ConsumerState<LessonPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(currentLessonProvider.state).state = widget.lesson;
      handleUserAction(ref, UserAction.viewLesson);
    });
    super.initState();
  }

  handleFailedState(String message) {
    final action = ref.read(userActionProvider);
    if (action.haveErrorShownBySnackBar) {
      showSnackbar(message, key: scaffoldKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lessonNotifier = ref.watch(lessonPageNotifierProvider);

    ref.listen<LessonPageState>(lessonPageNotifierProvider, (_, next) {
      next.maybeWhen(failed: handleFailedState, orElse: () {});
    });

    return Scaffold(
        key: scaffoldKey,
        body: lessonNotifier.when(
            loading: (message) => AppLoadingIndicator(message),
            content: _buildContent,
            failed: _buildFailed));
  }

  Widget _buildFailed(String message) {
    final action = ref.watch(userActionProvider);
    final lesson = ref.watch(currentLessonProvider);
    if (!action.haveErrorShownBySnackBar) {
      return FailedStateWidget(message);
    }
    return _buildContent(lesson);
  }

  Widget _buildContent(Lesson lesson) {
    final orientation = ref.watch(orientationModeProvider);
    final isLandscape = orientation == Orientation.landscape;
    return Scaffold(
        body: ListView(children: [
          LessonVideoPlayer(lesson.videoDetails),
          isLandscape ? Container() : _buildVideoDescription(lesson),
        ]),
        bottomNavigationBar: _buildBottomNavBar(lesson));
  }

  _buildVideoDescription(Lesson lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.dh),
        _buildTitle(lesson),
        SizedBox(height: 10.dh),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.dw),
            child: AppText(lesson.description)),
        AppDivider(margin: EdgeInsets.symmetric(vertical: 10.dh)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.dw),
          child: HTMLParser(lesson.body),
        )
      ],
    );
  }

  _buildTitle(Lesson lesson) {
    final isCompleted = lesson.completionStatus == Status.completed;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.dw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(lesson.title, color: AppColors.primaryVariant, size: 22.dw),
          isCompleted ? const CheckMark() : Container()
        ],
      ),
    );
  }

  _buildBottomNavBar(Lesson lesson) {
    final orientation = ref.watch(orientationModeProvider);
    return orientation == Orientation.landscape
        ? Container(height: .0001)
        : BottomAppBar(
            elevation: 10,
            child: Container(
              height: 70.dh,
              padding: EdgeInsets.symmetric(horizontal: 19.dw),
              child: Row(
                children: [
                  // _buildPrevButton(supp.isFirst),
                  _buildMarkStatusButton(lesson),
                  // _buildNextButton(supp.isLast),
                ],
              ),
            ),
          );
  }

  _buildMarkStatusButton(Lesson lesson) {
    final isIncomplete = lesson.completionStatus.isIncomplete;
    return Expanded(
        child: GestureDetector(
            onTap: () =>
                handleUserAction(ref, UserAction.markLessonCompletionStatus),
            child: Container(
              height: 50.dh,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: !isIncomplete
                      ? Border.all(color: AppColors.primary, width: 2)
                      : Border.all(color: Colors.transparent, width: 0),
                  color: isIncomplete ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.dw))),
              child: AppText(isIncomplete ? 'Mark Complete' : 'Mark Incomplete',
                  weight: FontWeight.bold,
                  color:
                      isIncomplete ? AppColors.onPrimary : AppColors.primary),
              margin: EdgeInsets.symmetric(horizontal: 30.dw),
            )));
  }
/*
  _buildNextButton(bool isLast) {
    return AppIconButton(
      onPressed: isLast ? () {} : bloc.goToNext,
      icon: EvaIcons.arrowheadRight,
      iconThemeData: Theme.of(context).iconTheme.copyWith(
          color: isLast ? AppColors.disabled : AppColors.onBackground),
    );
  }

  _buildPrevButton(bool isFirst) {
    return AppIconButton(
      onPressed: isFirst ? () {} : bloc.goToPrev,
      icon: EvaIcons.arrowheadLeft,
      iconThemeData: Theme.of(context).iconTheme.copyWith(
          color: isFirst ? AppColors.disabled : AppColors.onBackground),
    );
  } */
}
