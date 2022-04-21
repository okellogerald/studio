import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silla_studio/manager/onboarding/providers/pages.dart';
import 'package:silla_studio/pages/about_page.dart';
import 'package:silla_studio/pages/landing_page.dart';
import '../manager/onboarding/models/user_state.dart';
import '../manager/onboarding/providers/user_details.dart';
import '../manager/onboarding/providers/user_notifier.dart';
import '../manager/user_action.dart';
import '../widgets/app_divider.dart';
import '../widgets/app_material_button.dart';
import '../widgets/profile_avatar.dart';
import 'courses_page.dart';
import 'source.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final currentPage = Pages.profile_page;

  void handleSuccessState() {
    showSnackbar('You\'re successfully logged out',
        key: scaffoldKey, isError: false);
    pushAndRemoveUntil(const LandingPage());
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifierProvider);

    ref.listen(userNotifierProvider, (UserState? previous, UserState? next) {
      if (ref.read(pagesProvider) != currentPage) return;
      next!.maybeWhen(
          failed: (message) => showSnackbar(message, key: scaffoldKey),
          success: handleSuccessState,
          orElse: () {});
    });

    return Scaffold(
        key: scaffoldKey,
        body: userState.maybeWhen(
            loading: (message) => AppLoadingIndicator(message),
            failed: (_) => _buildContent(),
            orElse: _buildContent));
  }

  Widget _buildContent() {
    final userData = ref.read(signedInUserDataProvider)!;
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Column(children: [
          _buildTitle(userData['name']),
          SizedBox(height: 20.dh),
          _buildAccountDetails(),
          SizedBox(height: 20.dh),
          _buildOtherDetails()
        ])));
  }

  _buildTitle(String name) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15.dh),
        child: Column(children: [
          ProfileAvatar(name, size: 70.dw),
          SizedBox(height: 20.dh),
          AppText(name, size: 22.dw)
        ]));
  }

  _holdingContainer({required Widget child}) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.dw),
            color: AppColors.background,
            border: Border.all(width: 2, color: AppColors.surface)),
        margin: EdgeInsets.symmetric(horizontal: 15.dw),
        child: child);
  }

  _buildListView(List<Widget> children) {
    return _holdingContainer(
        child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) => children[index],
            separatorBuilder: (_, __) => AppDivider(
                margin: EdgeInsets.zero, color: AppColors.divider.shade300),
            itemCount: children.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics()));
  }

  _buildAccountDetails() {
    return _buildListView([
      _buildButton('Change Courses & Grade',
          onPressed: () => push(const CoursesPage())),
      _buildButton('Subscription')
    ]);
  }

  _buildOtherDetails() {
    return _buildListView([
      _buildButton('Terms & Conditions',
          onPressed: () => push(const AboutPage('https://flutter.dev/',
              title: 'Terms & Conditions'))),
      _buildButton('About Us',
          onPressed: () =>
              push(const AboutPage('https://dart.dev/', title: 'About Us'))),
      _buildButton('Log Out',
          isLogOut: true,
          onPressed: () => handleUserAction(ref, UserAction.logOut))
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
                    color: isLogOut ? AppColors.error : AppColors.onBackground),
                Icon(FontAwesomeIcons.angleRight,
                    size: 20.dw, color: AppColors.onBackground2)
              ],
            )));
  }
}
