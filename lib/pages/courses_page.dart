import 'package:silla_studio/pages/levels_page.dart';
import '../source.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  static navigateTo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const CoursesPage()));
  }

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  late final OnBoardingPagesBloc bloc;

  @override
  void initState() {
    bloc = Provider.of<OnBoardingPagesBloc>(context, listen: false);
    bloc.initCoursesPageState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingPagesBloc, OnBoardingPagesState>(
      listener: (_, state) {},
      builder: (_, state) {
        return state.when(
            laoding: _buildLoading,
            content: _buildContent,
            success: _buildContent,
            failed: _buildFailed);
      },
    );
  }

  Widget _buildLoading(OnBoardingSupplements supp, String? message) {
    return Scaffold(body: AppLoadingIndicator(message));
  }

  Widget _buildContent(OnBoardingSupplements supp) {
    return Scaffold(
      appBar: const PageAppBar(
          title: 'Choose Courses', subtitle: 'What would you like to learn ?'),
      body: _buildCourses(supp),
    );
  }

  _buildCourses(OnBoardingSupplements supp) {
    return ListView(
        padding: EdgeInsets.only(bottom: 20.dh),
        children: supp.courseTypes.map((e) {
          final courseList =
              supp.courseList.where((course) => course.type == e).toList();
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.dw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.dh),
                  child: AppText(e.toUpperCase(), size: 20.dw),
                ),
                SizedBox(height: 10.dh),
                _buildClassesGrid(courseList, supp)
              ],
            ),
          );
        }).toList());
  }

  _buildClassesGrid(List<Course> courseList, OnBoardingSupplements supp) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10.dw,
      mainAxisSpacing: 10.dh,
      children: courseList.map((course) {
        final isSelected = supp.user.courseId == course.id;

        return AppTextButton(
            onPressed:
                course.isPublished ? () => _onCoursePressed(course) : () {},
            borderRadius: 0,
            backgroundColor: course.isPublished
                ? AppColors.primaryVariant
                : AppColors.surface,
            child: Container(
                width: double.infinity,
                color: isSelected ? AppColors.primary : Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 10.dw),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      course.title,
                      alignment: TextAlign.center,
                      opacity: .85,
                      color: isSelected
                          ? AppColors.onPrimary
                          : AppColors.onBackground,
                    ),
                    !course.isPublished
                        ? Padding(
                            padding: EdgeInsets.only(top: 8.dh),
                            child: AppText('COMING SOON',
                                opacity: .7, size: 14.dw))
                        : Container()
                  ],
                )));
      }).toList(),
    );
  }

  void _onCoursePressed(Course course) {
    bloc.updateAttributes(
        courseId: course.id, gradeId: course.gradeList.first.id);

    if (course.levelList.isEmpty) {
      SignUpPage.navigateTo(context);
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => LevelsPage(course.levelList)));
    }
  }

  Widget _buildFailed(OnBoardingSupplements supp, String message) {
    return Scaffold(
        body: FailedStateWidget(message,
            tryAgainCallback: bloc.initCoursesPageState,
            title: 'Failed to load courses'));
  }
}
