import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../manager/onboarding/models/user_state.dart';
import '../manager/onboarding/provider/pages.dart';
import '../manager/onboarding/providers/user_details.dart';
import '../manager/onboarding/providers/user_notifier.dart';
import '../manager/user_action.dart';
import '../widgets/app_divider.dart';
import '../widgets/app_material_button.dart';
import '../widgets/failed_state_widget.dart';
import '../widgets/profile_avatar.dart';
import 'homepage.dart';
import 'source.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final currentPage = Pages.profile_page;

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

  void handleSuccessState() {
    final action = ref.read(userActionProvider);
    if (action == UserAction.logOut) {
      showSnackbar('You\'re successfully logged out', key: scaffoldKey);
      pushAndRemoveUntil(const Homepage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifierProvider);

    ref.listen(userNotifierProvider, (UserState? previous, UserState? next) {
      if (ref.read(pagesProvider) != currentPage) return;
      next!.maybeWhen(
          failed: handleFailedState,
          success: handleSuccessState,
          orElse: () {});
    });

    return Scaffold(
        body: userState.maybeWhen(
            loading: (message) => AppLoadingIndicator(message),
            failed: (message) => FailedStateWidget(message),
            orElse: _buildContent));
  }

  Widget _buildContent() {
    final userData = ref.read(signedInUserDataProvider);
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              _buildTitle(userData['name']),
              SizedBox(height: 20.dh),
              _buildAccountDetails(),
              const AppDivider(
                  height: 2,
                  color: AppColors.secondary,
                  margin: EdgeInsets.zero),
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

  _buildListView(List<Widget> children) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (_, index) => children[index],
      separatorBuilder: (_, __) => AppDivider(
          margin: EdgeInsets.zero, color: AppColors.divider.shade300),
      itemCount: children.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  _buildAccountDetails() {
    return _buildListView([
      _buildButton('Change Courses & Grade', FontAwesomeIcons.video),
      _buildButton('Subscription', FontAwesomeIcons.bookmark),
    ]);
  }

  _buildOtherDetails() {
    return _buildListView([
      _buildButton('Terms & Conditions', FontAwesomeIcons.fileContract),
      _buildButton('About Us', FontAwesomeIcons.circleInfo),
      _buildButton('Log Out', FontAwesomeIcons.arrowRightFromBracket,
          onPressed: () => handleUserAction(ref, UserAction.logOut),
          isLogOut: true),
    ]);
  }

  _buildButton(String title, IconData icon,
      {VoidCallback? onPressed, bool isLogOut = false}) {
    return AppMaterialButton(
        onPressed: onPressed ?? () {},
        isFilled: false,
        height: 45.dh,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 15.dw),
          leading: Icon(icon, size: 20.dw),
          title: AppText(title,
              color: isLogOut ? AppColors.error : AppColors.onBackground,
              weight: FontWeight.normal),
          trailing: Icon(FontAwesomeIcons.angleRight,
              size: 20.dw, color: AppColors.secondary.withOpacity(.6)),
        ));
  }
}
