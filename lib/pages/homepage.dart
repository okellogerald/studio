import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:silla_studio/manager/onboarding/user_details_providers.dart';
import '../manager/courses/homepage.dart';
import '../manager/courses/models/course_overview.dart';
import '../manager/user_action.dart';
import '../source.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  static navigateTo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const Homepage()));
  }

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  final controller = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      handleUserAction(ref, UserAction.viewHomepage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homepageNotifier = ref.watch(homepageNotifierProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: WillPopScope(
            onWillPop: () => showExitAppDialog(context),
            child: homepageNotifier.when(
                loading: (message) => AppLoadingIndicator(message),
                content: _buildContent,
                failed: (message) => FailedStateWidget(message)),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(CourseOverview overview, bool isUpdating) {
    final user = ref.watch(signedInUserDataProvider);
    return RefreshIndicator(
        onRefresh: ref.read(homepageNotifierProvider.notifier).refresh,
        child: Column(children: [
          _buildHeader(),
          Expanded(
              child: ListView(
                  shrinkWrap: true,
                  controller: controller,
                  padding: EdgeInsets.fromLTRB(15.dw, 0, 15.dw, 10.dh),
                  children: [
                _buildGeneralInfo(overview.generalInfo),
                _buildContinueLesson(overview.currentLesson),
                _buildTopics(user['grade'], overview.topicList),
              ]))
        ]));
  }

  _buildHeader() {
    final user = ref.watch(signedInUserDataProvider);
    final grade = user['grade'];
    final course = user['course'];

    return HomepageHeader(controller,
        title: 'Hello ' + user['name'].trim() + ',',
        subtitle: '$grade - $course',
        trailing: GestureDetector(
            onTap: () => push(const ProfilePage()),
            child: ProfileAvatar(user['name'])));
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AppText('Continue Class', weight: FontWeight.bold, size: 20.dw),
      SizedBox(height: 15.dh),
      LessonTile(lesson)
    ]);
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
