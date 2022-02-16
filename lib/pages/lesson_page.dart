import '../source.dart';

class LessonPage extends StatefulWidget {
  const LessonPage(this.lessonId, {Key? key}) : super(key: key);

  final String lessonId;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  late final LessonPageBloc bloc;

  @override
  void initState() {
    super.initState();
    final service = Provider.of<CoursesService>(context, listen: false);
    bloc = LessonPageBloc(service);
    bloc.init(widget.lessonId);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVideo(),
          _buildVideoDescription(supp.lesson),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  _buildVideo() => Container(height: 250.dh, color: Colors.yellow);

  _buildVideoDescription(Lesson lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.dh),
        _buildText(lesson.title, true),
        SizedBox(height: 10.dh),
        _buildText(lesson.topicName),
        AppDivider(margin: EdgeInsets.symmetric(vertical: 10.dh)),
        _buildText(lesson.description ?? '', false, .7)
      ],
    );
  }

  _buildText(String data, [bool isTitle = false, double opacity = 1]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.dw),
      child: AppText(data,
          weight: isTitle ? FontWeight.bold : FontWeight.normal,
          size: isTitle ? 22.dw : 16.dw,
          opacity: opacity),
    );
  }

  _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.withOpacity(.35)))),
      height: 70.dh,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: AppTextButton(
                onPressed: () {},
                height: 45.dh,
                backgroundColor: AppColors.surface,
                textColor: AppColors.onBackground,
                text: 'Mark As Complete',
                margin: EdgeInsets.symmetric(horizontal: 15.dw),
              )),
          Expanded(
              child: AppTextButton(
            onPressed: () {},
            text: 'NEXT',
            height: 45.dh,
            backgroundColor: AppColors.primary,
            textColor: AppColors.onPrimary,
            margin: EdgeInsets.symmetric(horizontal: 15.dw),
          )),
        ],
      ),
    );
  }
}
