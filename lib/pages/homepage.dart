import '../source.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  static navigateTo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const Homepage()));
  }

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final HomepageBloc bloc;

  @override
  void initState() {
    final service = Provider.of<CoursesService>(context, listen: false);
    final onBoardingBloc =
        Provider.of<OnBoardingPagesBloc>(context, listen: false);
    bloc = HomepageBloc(service, onBoardingBloc.service);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomepageBloc, HomepageState>(
          bloc: bloc,
          builder: (_, state) {
            return state.when(
                loading: _buildLoading,
                content: _buildContent,
                failed: (s, _) => _buildContent(s));
          }),
    );
  }

  Widget _buildLoading(HomepageSupplements supp, String? message) {
    return Scaffold(body: AppLoadingIndicator(message));
  }

  Widget _buildContent(HomepageSupplements supp) {
    return ListView(
      padding: EdgeInsets.fromLTRB(15.dw, 40.dh, 15.dw, 10.dh),
      children: [
        _buildTitle(supp.userData),
        _buildGeneralInfo(supp.generalInfo),
        _buildContinueLesson(supp.lesson),
        _buildTopics(supp.userData['grade'], supp.topicList),
      ],
    );
  }

  _buildTitle(Map userData) {
    final grade = userData['grade'];
    final course = userData['course'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText('Hello ' + userData['name'], size: 22.dw),
            SizedBox(height: 5.dh),
            AppText('$grade - $course'),
          ],
        ),
        CircleAvatar(
          backgroundColor: AppColors.primaryVariant,
          radius: 25.dw,
          child: AppText(
            userData['name'].toString().substring(0, 1),
            weight: FontWeight.bold,
            size: 25.dw,
            opacity: .7,
          ),
        )
      ],
    );
  }

  _buildGeneralInfo(GeneralInfo info) {
    return Container(
      height: 100.dh,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 25.dw),
      padding: EdgeInsets.symmetric(horizontal: 10.dw),
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(8.dw))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueIndicator(info.getRemainingClassesRatio),
              SizedBox(height: 10.dh),
              AppText('${info.remainingClasses} classes to complete Grade 1',
                  color: AppColors.onPrimary, size: 14.dw)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText('${info.getRemainingClassesPercent} %',
                  color: AppColors.onPrimary),
              SizedBox(height: 10.dh),
              AppText('COMPLETE', color: AppColors.onPrimary, size: 14.dw)
            ],
          ),
        ],
      ),
    );
  }

  _buildContinueLesson(Lesson lesson) {
    final isLearning = lesson.type == LessonType.learn;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Continue Class', weight: FontWeight.bold, size: 18.dw),
        SizedBox(height: 15.dh),
        LessonTile(
          title: lesson.title,
          topicId: lesson.topicId,
          subtitle:
              '${lesson.topicName} - ' + (isLearning ? 'LEARN' : 'PRACTICE'),
          image: Constants.kDefaultImage,
        ),
      ],
    );
  }

  _buildTopics(String grade, List<Topic> topicList) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('$grade - Topics', weight: FontWeight.bold, size: 18.dw),
          SizedBox(height: 15.dh),
          ListView.separated(
            separatorBuilder: (_, __) => SizedBox(height: 10.dh),
            itemCount: topicList.length,
            itemBuilder: (context, index) {
              final topic = topicList[index];
              return LessonTile(
                  title: topic.title,
                  image: Constants.kDefaultImage,
                  topicId: topic.id,
                  subtitle:
                      '${topic.completedLessons} / ${topic.totalLessons} videos completed');
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}