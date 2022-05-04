import 'package:silla_studio/manager/onboarding/models/user.dart';
import 'package:silla_studio/pages/profile_page.dart';
import '../manager/homepage/models/general_info.dart';
import '../manager/homepage/providers.dart';
import '../manager/homepage/models/course_overview.dart';
import '../manager/lesson_page/models/lesson.dart';
import '../manager/onboarding/providers/user_details.dart';
import '../manager/topic_page/models/topic.dart';
import '../manager/user_action.dart';
import '../widgets/completion_progress_bar.dart';
import '../widgets/failed_state_widget.dart';
import '../widgets/homepage_header.dart';
import '../widgets/lesson_tile.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/topic_tile.dart';
import 'source.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({Key? key}) : super(key: key);

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

  Widget _buildContent(CourseOverview overview) {
    //~ avoiding null-check errors during sign out
    final user = ref.watch(signedInUserDataProvider) ?? User.defaultUserData();
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
    //~ avoiding null-check errors during sign out
    final user = ref.watch(signedInUserDataProvider) ?? User.defaultUserData();
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
    //~ avoiding null-check errors during sign out
    final user = ref.watch(signedInUserDataProvider) ?? User.defaultUserData();
    final grade = user['grade'];

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
              AppText('${info.remainingClasses} classes to complete $grade',
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
      AppText('Continue Class',
          weight: FontWeight.bold, size: 20.dw, color: const Color(0xff666666)),
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
          AppText('$grade - Topics',
              weight: FontWeight.bold,
              size: 20.dw,
              color: const Color(0xff666666)),
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
