import '../manager/onboarding/models/user_state.dart';
import '../manager/onboarding/provider/pages.dart';
import '../manager/onboarding/providers/user_details.dart';
import '../manager/onboarding/providers/user_notifier.dart';
import '../manager/user_action.dart';
import '../widgets/failed_state_widget.dart';
import '../widgets/page_app_bar.dart';
import 'source.dart';

class PasswordResetPage extends ConsumerStatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  static navigateTo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const PasswordResetPage()));
  }

  @override
  ConsumerState<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends ConsumerState<PasswordResetPage> {
  final currentPage = Pages.password_reset_page;
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

  void handleSuccessState() {
    final user = ref.read(userDetailsProvider);
    showSnackbar('Password reset link has been sent to ${user.email}');
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
        body: WillPopScope(
      onWillPop: () => handleStateOnPop(ref, Pages.login_page),
      child: userState.maybeWhen(
          loading: (message) => AppLoadingIndicator(message),
          failed: (message) => FailedStateWidget(message),
          orElse: _buildContent),
    ));
  }

  Widget _buildContent() {
    return Scaffold(
      appBar: const PageAppBar(title: 'Password Reset'),
      body: Padding(
        padding: EdgeInsets.only(top: 10.dh, left: 15.dw, right: 15.dw),
        child: Column(
          children: [
            const AppText(
              'We sent a link to your email address. Click on the link to create a new password.',
              opacity: .7,
            ),
            SizedBox(height: 30.dh),
            _buildResendCode(),
          ],
        ),
      ),
    );
  }

  _buildResendCode() {
    final user = ref.watch(userDetailsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Email sent to ${user.email}'),
        SizedBox(height: 10.dh),
        Row(
          children: [
            const AppText('Didn\'t get it ?'),
            AppTextButton(
              onPressed: ref
                  .read(userNotifierProvider.notifier)
                  .sendPasswordResetEmail,
              text: 'Resend Code',
              textColor: AppColors.primary,
              margin: EdgeInsets.only(left: 20.dw),
            )
          ],
        ),
      ],
    );
  }
}
