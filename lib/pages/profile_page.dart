import '../source.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfilePageBloc bloc;

  @override
  void initState() {
    final coursesService = Provider.of<CoursesService>(context, listen: false);
    final userService =
        Provider.of<OnBoardingPagesBloc>(context, listen: false).service;
    bloc = ProfilePageBloc(coursesService, userService);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfilePageBloc, ProfilePageState>(
          bloc: bloc,
          listener: (_, state) {
            final isSignedOut =
                state.maybeWhen(success: (_) => true, orElse: () => false);

            if (isSignedOut) _navigateToLandingPage();
          },
          builder: (_, state) {
            return state.when(
                loading: _buildLoading,
                content: _buildContent,
                failed: _buildFailed,
                success: _buildContent);
          }),
    );
  }

  _navigateToLandingPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LandingPage()),
        (route) => false);
  }

  Widget _buildLoading(Map<String, dynamic> userData, String? message) {
    return Scaffold(body: AppLoadingIndicator(message));
  }

  Widget _buildFailed(Map<String, dynamic> userData, String message) {
    return Scaffold(
        body: FailedStateWidget(message,
            tryAgainCallback: bloc.init, title: 'Failed to load your profile'));
  }

  Widget _buildContent(Map<String, dynamic> userData) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              _buildTitle(userData['name']),
              SizedBox(height: 20.dh),
              _buildAccountDetails(),
              SizedBox(height: 20.dh),
              _buildOtherDetails(),
            ],
          ),
        ));
  }

  _buildTitle(String name) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15.dh),
        child: Column(
          children: [
            ProfileAvatar(name, size: 70.dw),
            SizedBox(height: 20.dh),
            AppText(name, size: 22.dw)
          ],
        ));
  }

  _holdingContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.dw),
        color: AppColors.background,
        boxShadow: const [
          BoxShadow(
              color: AppColors.divider,
              blurRadius: .5,
              spreadRadius: .5,
              offset: Offset(.4, .1))
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 15.dw),
      child: child,
    );
  }

  _buildListView(List<Widget> children) {
    return _holdingContainer(
      child: ListView.separated(
        itemBuilder: (_, index) => children[index],
        separatorBuilder: (_, __) => AppDivider(
            margin: EdgeInsets.zero, color: AppColors.divider.shade300),
        itemCount: children.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }

  _buildTextButton(String title,
      {VoidCallback? onPressed, bool isLogOut = false}) {
    return AppTextButton(
      onPressed: onPressed ?? () {},
      text: title,
      alignment: Alignment.centerLeft,
      textColor: isLogOut ? AppColors.error : AppColors.onBackground,
      height: 45.dh,
      padding: EdgeInsets.only(left: 15.dw),
    );
  }

  _buildAccountDetails() {
    return _buildListView([
      _buildTextButton('Change Courses & Grade'),
      _buildTextButton('Subscription'),
    ]);
  }

  _buildOtherDetails() {
    return _buildListView([
      _buildTextButton('Terms & Conditions'),
      _buildTextButton('About Us'),
      _buildTextButton('Log Out', isLogOut: true, onPressed: bloc.logOut),
    ]);
  }
}