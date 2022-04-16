import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/pages/levels_page.dart';
import '../manager/onboarding/courses_provider.dart';
import '../manager/onboarding/models/user_state.dart';
import '../manager/onboarding/user_details_providers.dart';
import '../manager/onboarding/user_notifier.dart';
import '../manager/pages.dart';
import '../manager/user_action.dart';
import '../source.dart' hide Provider;

class CoursesPage extends ConsumerStatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends ConsumerState<CoursesPage> {
  final scrollController = ScrollController();
  final currentPage = Pages.courses_page;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    handleStateOnInit(ref, currentPage);
    super.initState();
  }

  void handleFailedState(String message) {
    final action = ref.read(userActionProvider);
    if (action.haveErrorShownBySnackBar) {
      showSnackbar(message, key: scaffoldKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifierProvider);

    ref.listen(userNotifierProvider, (UserState? previous, UserState? next) {
      if (ref.read(pagesProvider) != currentPage) return;
      next!.maybeWhen(failed: handleFailedState, orElse: () {});
    });

    return Scaffold(
        body: WillPopScope(
      onWillPop: () => handleStateOnPop(ref, Pages.courses_page),
      child: userState.maybeWhen(
          loading: (message) => AppLoadingIndicator(message),
          failed: (message) => FailedStateWidget(message),
          orElse: _buildContent),
    ));
  }

  Widget _buildContent() {
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
              _buildCourses(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourses() {
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
                  _buildClassesGrid(type)
                ],
              ),
            );
          }).toList()),
    );
  }

  _buildClassesGrid(String type) {
    final user = ref.watch(userDetailsProvider);
    final courseList = ref.read(coursesProvider);
    final courses = courseList.where((course) => course.type == type).toList();
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10.dw,
      mainAxisSpacing: 10.dh,
      children: courses.map((course) {
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
                          : AppColors.primaryVariant,
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
    updateUserDetails(ref,
        courseId: course.id, gradeId: course.gradeList.first.id);

    if (course.levelList.isEmpty) {
      push(const SignUpPage());
      return;
    }
    push(LevelsPage(course.levelList));
  }
}
