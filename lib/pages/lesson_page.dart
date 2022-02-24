import '../source.dart';

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
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryVariant),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVideo(),
          _buildVideoDescription(supp.lesson),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(supp),
    );
  }

  _buildVideo() => Container(height: 150.dh, color: AppColors.primaryVariant);

  _buildVideoDescription(Lesson lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.dh),
        _buildTitle(lesson),
        SizedBox(height: 10.dh),
        _buildText(lesson.description ?? ''),
        AppDivider(margin: EdgeInsets.symmetric(vertical: 10.dh)),
        _buildText(lesson.body ?? '', .7)
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
          AppText(lesson.title, weight: FontWeight.bold, size: 22.dw),
          isCompleted ? const CheckMark() : Container()
        ],
      ),
    );
  }

  _buildText(String data, [double opacity = 1]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.dw),
      child: AppText(data,
          weight: FontWeight.normal,
          opacity: opacity),
    );
  }

  _buildBottomNavBar(LessonPageSupplements supp) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.grey.withOpacity(.15), width: 2))),
      height: 80.dh,
      child: Row(
        children: [
          _buildMarkStatusButton(supp.lesson),
          _buildNextButton(supp.isLast),
        ],
      ),
    );
  }

  _buildMarkStatusButton(Lesson lesson) {
    final isIncomplete = lesson.completionStatus == 'incomplete';
    return Expanded(
        flex: 2,
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
                  borderRadius: BorderRadius.all(Radius.circular(5.dw))),
              child: AppText(isIncomplete ? 'MARK COMPLETE' : 'MARK INCOMPLETE',
                  color:
                      isIncomplete ? AppColors.onPrimary : AppColors.primary),
              margin: EdgeInsets.symmetric(horizontal: 15.dw),
            )));
  }

  _buildNextButton(bool isLast) {
    if (isLast) return Container();
    return Expanded(
        child: AppTextButton(
      onPressed: bloc.goToNext,
      text: 'NEXT',
      height: 50.dh,
      backgroundColor: AppColors.primary,
      textColor: AppColors.onPrimary,
      margin: EdgeInsets.only(right: 15.dw),
    ));
  }
}
