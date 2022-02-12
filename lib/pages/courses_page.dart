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
      body: _buildCourses(),
    );
  }

  _buildCourses() {
    return Container();
  }

  Widget _buildFailed(OnBoardingSupplements supp, String message) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.dw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText('Failed to load courses', size: 22.dw),
            SizedBox(height: 20.dh),
            AppText(message),
            AppTextButton(
              onPressed: bloc.initCoursesPageState,
              text: 'Try Again',
              height: 40.dh,
              margin: EdgeInsets.only(top: 20.dh),
            )
          ],
        ),
      ),
    );
  }
}
