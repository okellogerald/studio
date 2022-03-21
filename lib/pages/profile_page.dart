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

            if (isSignedOut) pushAndRemoveUntil(const LandingPage());
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
          borderRadius: BorderRadius.circular(10.dw),
          color: AppColors.background,
          border: Border.all(width: 2, color: AppColors.surface)),
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

  _buildAccountDetails() {
    return _buildListView([
      _buildButton('Change Courses & Grade'),
      _buildButton('Subscription'),
    ]);
  }

  _buildOtherDetails() {
    return _buildListView([
      _buildButton('Terms & Conditions'),
      _buildButton('About Us'),
      _buildButton('Log Out', onPressed: bloc.logOut, isLogOut: true),
    ]);
  }

  _buildButton(String title, {VoidCallback? onPressed, bool isLogOut = false}) {
    return AppMaterialButton(
        onPressed: onPressed ?? () {},
        isFilled: false,
        height: 60.dh,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.dw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(title,
                    color: isLogOut ? AppColors.error : AppColors.onBackground,
                    weight: FontWeight.normal),
                isLogOut
                    ? Container()
                    : Icon(Icons.chevron_right,
                        size: 20.dw,
                        color: AppColors.secondary.withOpacity(.85))
              ],
            )));
  }
}
