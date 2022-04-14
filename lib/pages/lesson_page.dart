import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:silla_studio/manager/video_page/providers.dart';
import '../source.dart' hide Consumer;
import 'video_page.dart';

class LessonPage extends StatefulWidget {
  const LessonPage(this.lessonId, this.lessonsIdList, {Key? key})
      : super(key: key);

  final String lessonId;
  final List<String> lessonsIdList;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  late final LessonPageBloc bloc;

  @override
  void initState() {
    final service = Provider.of<LessonsService>(context, listen: false);
    bloc = LessonPageBloc(service);
    bloc.init(widget.lessonId, widget.lessonsIdList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonPageBloc, LessonPageState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              failed: (s, _) => _buildContent(s));
        });
  }

  Widget _buildLoading(LessonPageSupplements supp, String? message) {
    return Scaffold(body: Center(child: AppLoadingIndicator(message)));
  }

  Widget _buildContent(LessonPageSupplements supp) {
    return Consumer(builder: (context, ref, child) {
      final orientation = ref.watch(orientationModeProvider);
      final isLandscape = orientation == Orientation.landscape;
      return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const LessonVideoPlayer(),
          isLandscape ? Container() : _buildVideoDescription(supp.lesson),
        ]),
        bottomNavigationBar: _buildBottomNavBar(supp, ref),
      );
    });
  }

  _buildVideoDescription(Lesson lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.dh),
        _buildTitle(lesson),
        SizedBox(height: 10.dh),
        _buildText(lesson.description ?? ''),
        AppDivider(margin: EdgeInsets.symmetric(vertical: 10.dh)),
        _buildText(lesson.body ?? '', true)
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

  _buildText(String data, [bool isBody = false]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.dw),
      child: AppText(data, opacity: isBody ? .7 : 1),
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
