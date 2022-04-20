import 'package:silla_studio/pages/levels_page.dart';
import 'package:silla_studio/pages/signup_page.dart';
import '../manager/onboarding/models/course.dart';
import '../manager/onboarding/providers/courses.dart';
import '../manager/onboarding/providers/user_details.dart';
import '../manager/user_action.dart';
import '../widgets/app_material_button.dart';
import '../widgets/failed_state_widget.dart';
import '../widgets/page_animated_app_bar.dart';
import 'source.dart';

class CoursesPage extends ConsumerStatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends ConsumerState<CoursesPage> {
  final scrollController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final courses = ref.watch(coursesProvider);

    return Scaffold(
      body: courses.when(
          data: _buildContent,
          error: (message, _) => FailedStateWidget(message.toString()),
          loading: () => const AppLoadingIndicator('Getting courses...')),
    );
  }

  Widget _buildContent(List<Course> courses) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              PageAnimatedAppBar(
                  title: 'Choose Courses',
                  subtitle: 'What would you like to learn ?',
                  scrollController: scrollController),
              _buildCourses(courses),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourses(List<Course> courses) {
    final courseTypes = ref.read(coursesTypesProvider);

    return Expanded(
      child: ListView(
          controller: scrollController,
          padding: EdgeInsets.only(bottom: 20.dh),
          children: courseTypes.map((type) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.dw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40.dh),
                    child: AppText(type.toUpperCase(), size: 20.dw),
                  ),
                  SizedBox(height: 10.dh),
                  _buildClassesGrid(courses, type)
                ],
              ),
            );
          }).toList()),
    );
  }

  _buildClassesGrid(List<Course> courses, String type) {
    final user = ref.watch(userDetailsProvider);
    final filteredCourses =
        courses.where((course) => course.type == type).toList();
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10.dw,
      mainAxisSpacing: 10.dh,
      children: filteredCourses.map((course) {
        final isSelected = user.courseId == course.id;

        return AppMaterialButton(
            onPressed:
                course.isPublished ? () => _onCoursePressed(course) : () {},
            backgroundColor: AppColors.surface,
            borderRadius: 10.dw,
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.dw),
                decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10.dw))),
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
                                opacity: .5, size: 14.dw))
                        : Container()
                  ],
                )));
      }).toList(),
    );
  }

  void _onCoursePressed(Course course) {
    updateUserDetails(ref,
        courseId: course.id, gradeId: course.gradeList.first.id);

    if (course.levelList.isEmpty) {
      push(const SignUpPage());
      return;
    }
    push(LevelsPage(course.levelList));
  }
}
