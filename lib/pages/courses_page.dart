import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:silla_studio/pages/levels_page.dart';
import '../errors/app_error.dart';
import '../manager/user/user_actions.dart';
import '../source.dart';

class CoursesPage extends ConsumerStatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  static navigateTo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const CoursesPage()));
  }

  @override
  ConsumerState<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends ConsumerState<CoursesPage> {
  late final OnBoardingPagesBloc bloc;
  final scrollController = ScrollController();
  final currentPage = Pages.coursesPage;

  @override
  void initState() {
    bloc = Provider.of<OnBoardingPagesBloc>(context, listen: false);
    bloc.init(currentPage);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(userActionProvider.state).state = UserActivity.coursesView;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnBoardingPagesBloc, OnBoardingPagesState>(
        listener: (context, state) {
          final error = state.maybeWhen(
              failed: (_, __, error) => error, orElse: () => null);
          if (error != null && error.isShownViaSnackBar) {
            showSnackbar(error.message, context: context);
          }
        },
        listenWhen: (_, current) => current.page == currentPage,
        buildWhen: (_, current) => current.page == currentPage,
        builder: (_, state) {
          log('building in the $currentPage');
          return state.when(
              laoding: _buildLoading,
              content: _buildContent,
              success: _buildContent,
              failed: _buildFailed);
        },
      ),
    );
  }

  Widget _buildLoading(
      Pages page, OnBoardingSupplements supp, String? message) {
    return Scaffold(body: AppLoadingIndicator(message));
  }

  Widget _buildContent(Pages page, OnBoardingSupplements supp) {
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
              _buildCourses(supp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourses(OnBoardingSupplements supp) {
    return Expanded(
      child: ListView(
          controller: scrollController,
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
          }).toList()),
    );
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
    bloc.updateAttributes(
        courseId: course.id, gradeId: course.gradeList.first.id);

    if (course.levelList.isEmpty) {
      push(const SignUpPage());
      return;
    }
    push(LevelsPage(course.levelList));
  }

  Widget _buildFailed(Pages page, OnBoardingSupplements supp, AppError error) {
    if (error.isShownViaSnackBar) return _buildContent(page, supp);
    return Scaffold(
        body: FailedStateWidget(error.message,
            tryAgainCallback: () => bloc.init(currentPage)));
  }
}
