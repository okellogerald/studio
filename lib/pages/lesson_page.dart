import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:silla_studio/manager/video/providers.dart';

import '../errors/app_error.dart';
import '../manager/user/user_actions.dart';
import '../manager/video/providers.dart';
import '../source.dart' hide Consumer;
import '../widgets/html_parser.dart';
import '../widgets/lesson_video_player.dart';

class LessonPage extends ConsumerStatefulWidget {
  const LessonPage(this.lessonId, this.lessonsIdList, {Key? key})
      : super(key: key);

  final String lessonId;
  final List<String> lessonsIdList;

  @override
  ConsumerState<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends ConsumerState<LessonPage> {
  late final LessonPageBloc bloc;

  @override
  void initState() {
    final service = Provider.of<LessonsService>(context, listen: false);
    bloc = LessonPageBloc(service);
    bloc.init(widget.lessonId, widget.lessonsIdList);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(userActionProvider.state).state = UserActivity.lessonPageView;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LessonPageBloc, LessonPageState>(
          bloc: bloc,
          listener: (context, state) {
            final error = state.maybeWhen(
                failed: (_, error) => error, orElse: () => null);
            if (error != null && error.isShownViaSnackBar) {
              showSnackbar(error.message, context: context);
              if (error.isVideoNotFound) pop();
            }
          },
          builder: (_, state) {
            return state.when(
                loading: _buildLoading,
                content: _buildContent,
                failed: _buildFailed);
          }),
    );
  }

  Widget _buildLoading(LessonPageSupplements supp, String? message) {
    return Scaffold(body: Center(child: AppLoadingIndicator(message)));
  }

  Widget _buildFailed(LessonPageSupplements supp, AppError error) {
    // if (error.isShownViaSnackBar) return _buildContent(supp);
    return Scaffold(
        body: FailedStateWidget(error.message, tryAgainCallback: () {
      bloc.init(widget.lessonId, widget.lessonsIdList);
    }));
  }

  Widget _buildContent(LessonPageSupplements supp) {
    return Consumer(builder: (context, ref, child) {
      final orientation = ref.watch(orientationModeProvider);
      final isLandscape = orientation == Orientation.landscape;
      return Scaffold(
          body: ListView(children: [
            LessonVideoPlayer(supp.videoDetails),
            isLandscape ? Container() : _buildVideoDescription(supp.lesson),
          ]),
          bottomNavigationBar: _buildBottomNavBar(supp, ref));
    });
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
            child: AppText(lesson.description ?? '')),
        AppDivider(margin: EdgeInsets.symmetric(vertical: 10.dh)),
        HTMLParser(lesson.body)
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

  _buildBottomNavBar(LessonPageSupplements supp, WidgetRef ref) {
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
                  _buildPrevButton(supp.isFirst),
                  _buildMarkStatusButton(supp.lesson),
                  _buildNextButton(supp.isLast),
                ],
              ),
            ),
          );
  }

  _buildMarkStatusButton(Lesson lesson) {
    final isIncomplete = lesson.completionStatus == 'incomplete';
    return Expanded(
        child: GestureDetector(
            onTap: isIncomplete
                ? () => bloc.markLessonAs(Status.completed, lesson: lesson)
                : () => bloc.markLessonAs(Status.incomplete, lesson: lesson),
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
  }
}
