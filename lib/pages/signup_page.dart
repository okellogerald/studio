import '../manager/onboarding/models/user_state.dart';
import '../manager/onboarding/providers/pages.dart';
import '../manager/onboarding/providers/user_details.dart';
import '../manager/onboarding/providers/user_notifier.dart';
import '../manager/user_action.dart';
import '../widgets/app_text_field.dart';
import '../widgets/failed_state_widget.dart';
import '../widgets/page_app_bar.dart';
import 'homepage.dart';
import 'source.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static navigateTo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const SignUpPage()));
  }

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final currentPage = Pages.signup_page;

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
      next!.maybeWhen(
          failed: handleFailedState,
          success: () => pushAndRemoveUntil(const Homepage()),
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
    final confirmationPassword = ref.watch(confirmationPasswordProvider);
    return Scaffold(
      appBar: const PageAppBar(
          title: 'One Last Thing !',
          subtitle: 'Let\'s create an account for you.'),
      body: ListView(
        padding: EdgeInsets.only(top: 40.dh),
        children: [
          AppTextField(
            error: errors['email'],
            text: user.email,
            onChanged: (email) => updateUserDetails(ref, email: email),
            hintText: '',
            keyboardType: TextInputType.emailAddress,
            label: 'Email Id',
          ),
          AppTextField(
            error: errors['password'],
            text: password,
            onChanged: (password) => updateUserDetails(ref, password: password),
            hintText: '',
            keyboardType: TextInputType.emailAddress,
            label: 'Password',
            isPassword: true,
          ),
          AppTextField(
            error: errors['confirm_password'],
            text: confirmationPassword,
            onChanged: (password) =>
                updateUserDetails(ref, confirmationPassword: password),
            hintText: '',
            keyboardType: TextInputType.emailAddress,
            label: 'confirmationPassowrd',
            isPassword: true,
            isLoginPassword: true,
          ),
        ],
      ),
      bottomNavigationBar: _buildGetStartedButton(),
    );
  }

  _buildGetStartedButton() {
    return BottomAppBar(
      child: AppTextButton(
        onPressed:() => handleUserAction(ref, UserAction.signUp),
        text: 'GET STARTED',
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
