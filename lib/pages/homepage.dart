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
  final controller = ScrollController();

  @override
  void initState() {
    final service = Provider.of<CoursesService>(context, listen: false);
    final lessonsService = Provider.of<LessonsService>(context, listen: false);
    final onBoardingBloc =
        Provider.of<OnBoardingPagesBloc>(context, listen: false);
    bloc = HomepageBloc(service, onBoardingBloc.service, lessonsService);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<HomepageBloc, HomepageState>(
              bloc: bloc,
              listener: (context, state) {
                final error = state.maybeWhen(
                    failed: (_, error, __) => error, orElse: () => null);

                if (error != null) {
                  final isShownOnScreen = state.maybeWhen(
                      failed: (_, __, shownOnScreen) => shownOnScreen,
                      orElse: () => false);
                  if (!isShownOnScreen) showSnackbar(error, context: context);
                }
              },
              builder: (_, state) {
                return state.when(
                    loading: _buildLoading,
                    content: _buildContent,
                    failed: _buildFailed);
              }),
        ),
      ),
    );
  }

  Widget _buildLoading(
      HomepageSupplements supp, String? message, bool isUpdatingContent) {
    if (isUpdatingContent) {
      return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [_buildContent(supp), const LinearProgressIndicator()]);
    }
    return AppLoadingIndicator(message);
  }

  Widget _buildFailed(
      HomepageSupplements supp, String message, bool showOnScreen) {
    if (!showOnScreen) return _buildContent(supp);
    return FailedStateWidget(message,
        tryAgainCallback: bloc.init, title: 'Failed to load your information');
  }

  Widget _buildContent(HomepageSupplements supp) {
    return RefreshIndicator(
        onRefresh: bloc.refresh,
        child: Column(children: [
          _buildHeader(supp.userData),
          Expanded(
              child: ListView(
                  shrinkWrap: true,
                  controller: controller,
                  padding: EdgeInsets.fromLTRB(15.dw, 0, 15.dw, 10.dh),
                  children: [
                _buildGeneralInfo(supp.generalInfo),
                _buildContinueLesson(supp.lesson),
                _buildTopics(supp.userData['grade'], supp.topicList),
              ]))
        ]));
  }

  _buildHeader(Map userData) {
    final grade = userData['grade'];
    final course = userData['course'];

    return HomepageHeader(controller,
        title: 'Hello ' + userData['name'].trim() + ',',
        subtitle: '$grade - $course',
        trailing: GestureDetector(
            onTap: _navigateToProfilePage,
            child: ProfileAvatar(userData['name'])));
  }

  _buildGeneralInfo(GeneralInfo info) {
    return Container(
      height: 100.dh,
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.dh, bottom: 25.dh),
      padding: EdgeInsets.fromLTRB(15.dw, 10.dw, 15.dw, 0),
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
              CompletionProgressBar(info.getRemainingClassesRatio),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Continue Class', weight: FontWeight.bold, size: 20.dw),
        SizedBox(height: 15.dh),
        LessonTile(lesson, [lesson.id]),
      ],
    );
  }

  _buildTopics(String grade, List<Topic> topicList) {
    return Padding(
      padding: EdgeInsets.only(top: 20.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText('$grade - Topics', weight: FontWeight.bold, size: 20.dw),
          SizedBox(height: 15.dh),
          ListView.separated(
            separatorBuilder: (_, __) => SizedBox(height: 10.dh),
            itemCount: topicList.length,
            itemBuilder: (context, index) => TopicTile(topicList[index]),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  _navigateToProfilePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ProfilePage()));
  }
}
