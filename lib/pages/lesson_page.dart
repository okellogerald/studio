import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:silla_studio/manager/video/providers.dart';
import '../manager/courses/lesson_page.dart';
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
  @override
  Widget build(BuildContext context) {
    final lesson = ref.watch(lessonProvider(widget.lessonId));

    return Scaffold(
      body: lesson.when(
          data: _buildContent,
          error: (message, _) => FailedStateWidget(message.toString()),
          loading: () => const AppLoadingIndicator('Getting lesson data')),
    );
  }

  Widget _buildContent(Lesson lesson) {
    return Consumer(builder: (context, ref, child) {
      final orientation = ref.watch(orientationModeProvider);
      final isLandscape = orientation == Orientation.landscape;
      return Scaffold(
          body: ListView(children: [
            LessonVideoPlayer(lesson.videoDetails),
            isLandscape ? Container() : _buildVideoDescription(lesson),
          ]),
          bottomNavigationBar: _buildBottomNavBar());
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
            child: AppText(lesson.description)),
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

  _buildBottomNavBar() {
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
                  //  _buildPrevButton(supp.isFirst),
                  //   _buildMarkStatusButton(supp.lesson),
                  // _buildNextButton(supp.isLast),
                ],
              ),
            ),
          );
  }
/* 
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
  } */
}
