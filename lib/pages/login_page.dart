import '../manager/onboarding/models/user_state.dart';
import '../manager/onboarding/provider/pages.dart';
import '../manager/onboarding/providers/user_details.dart';
import '../manager/onboarding/providers/user_notifier.dart';
import '../manager/user_action.dart';
import '../widgets/app_text_field.dart';
import '../widgets/failed_state_widget.dart';
import '../widgets/page_app_bar.dart';
import 'homepage.dart';
import 'password_reset_page.dart';
import 'source.dart';

class LogInPage extends ConsumerStatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends ConsumerState<LogInPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final currentPage = Pages.login_page;

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
    if (action == UserAction.logIn) pushAndRemoveUntil(const Homepage());
    if (action == UserAction.sendPasswordResetLink) {
      push(const PasswordResetPage());
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
    final errors = ref.watch(userValidationErrorsProvider);
    final user = ref.watch(userDetailsProvider);
    final password = ref.watch(passwordProvider);
    return Scaffold(
      key: scaffoldKey,
      appBar: const PageAppBar(title: 'Welcome back to Siila !'),
      body: Padding(
        padding: EdgeInsets.only(top: 40.dh),
        child: Column(
          children: [
            AppTextField(
                error: errors['email'],
                text: user.email,
                onChanged: (email) => updateUserDetails(ref, email: email),
                hintText: '',
                keyboardType: TextInputType.emailAddress,
                label: 'Email Id'),
            AppTextField(
                error: errors['password'],
                text: password,
                onChanged: (password) =>
                    updateUserDetails(ref, password: password),
                hintText: '',
                keyboardType: TextInputType.emailAddress,
                label: 'Password',
                isLoginPassword: true),
            _buildForgotPassword(),
          ],
        ),
      ),
      bottomNavigationBar: _buildLogInButton(),
    );
  }

  _buildForgotPassword() {
    return Padding(
      padding: EdgeInsets.only(top: 10.dh, left: 15.dw),
      child: Row(
        children: [
          const AppText('Forgot Password ?'),
          AppTextButton(
            onPressed: () =>
                handleUserAction(ref, UserAction.sendPasswordResetLink),
            text: 'Reset',
            textColor: AppColors.primary,
            margin: EdgeInsets.only(left: 10.dw),
          )
        ],
      ),
    );
  }

  _buildLogInButton() {
    return BottomAppBar(
      child: AppTextButton(
        onPressed: () => handleUserAction(ref, UserAction.logIn),
        text: 'LOG IN',
        textColor: AppColors.onPrimary,
        backgroundColor: AppColors.primary,
        height: 50.dh,
        width: 200.dw,
        borderRadius: 30.dw,
        margin: EdgeInsets.only(bottom: 30.dh, right: 15.dw, left: 15.dw),
      ),
    );
  }
}
