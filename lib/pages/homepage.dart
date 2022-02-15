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
        _buildGeneralInfo(),
        _buildContinueLesson(),
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
          radius: 30.dw,
          child: AppText(
            userData['name'].toString().substring(0, 1),
            weight: FontWeight.bold,
            size: 30.dw,
            opacity: .7,
          ),
        )
      ],
    );
  }

  _buildGeneralInfo() {
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
              const ValueIndicator(),
              SizedBox(height: 10.dh),
              AppText('23 classes to complete Grade 1',
                  color: AppColors.onPrimary, size: 14.dw)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppText('45 %', color: AppColors.onPrimary),
              SizedBox(height: 10.dh),
              AppText('COMPLETE', color: AppColors.onPrimary, size: 14.dw)
            ],
          ),
        ],
      ),
    );
  }

  _buildContinueLesson() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Continue Lesson', size: 18.dw),
        SizedBox(height: 10.dh),
        Container(
          height: 100.dh,
          padding: EdgeInsets.symmetric(horizontal: 12.dw),
          decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.all(Radius.circular(8.dw))),
          child: Row(
            children: [
              ClipRRect(
               borderRadius: BorderRadius.all(Radius.circular(8.dw)), 
                child: Image.network(
                    'https://images.pexels.com/photos/339352/carnival-fasnet-swabian-alemannic-wooden-mask-339352.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                    width: 100.dw,
                    height: 80.dh,
                    fit: BoxFit.cover),
              ),
              SizedBox(width: 20.dw),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText('Some Course', opacity: .7, size: 18.dw),
                  SizedBox(height: 5.dh),
                  const AppText('Course name', opacity: .7),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
