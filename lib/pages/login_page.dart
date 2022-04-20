import 'package:silla_studio/manager/onboarding/providers/pages.dart';
import '../manager/onboarding/models/user_state.dart';
import '../manager/onboarding/providers/user_details.dart';
import '../manager/onboarding/providers/user_notifier.dart';
import '../manager/user_action.dart';
import '../widgets/app_text_field.dart';
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
  final formKey = GlobalKey<FormState>();
  final currentPage = Pages.login_page;

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifierProvider);

    ref.listen(userNotifierProvider, (UserState? previous, UserState? next) {
      if (ref.read(pagesProvider) != currentPage) return;
      next!.maybeWhen(
          failed: (message) => showSnackbar(message, key: scaffoldKey),
          success: () => pushAndRemoveUntil(const Homepage()),
          orElse: () {});
    });

    return Scaffold(
        body: userState.maybeWhen(
            loading: (message) => AppLoadingIndicator(message),
            failed: (_) => _buildContent(),
            orElse: _buildContent));
  }

  Widget _buildContent() {
    return Scaffold(
      key: scaffoldKey,
      appBar: const PageAppBar(title: 'Welcome back to Siila !'),
      body: Padding(
        padding: EdgeInsets.only(top: 40.dh),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AppTextField(
                  text: ref.watch(userDetailsProvider).email,
                  type: ValueType.email,
                  onChanged: (email) => updateUserDetails(ref, email: email),
                  hintText: '',
                  keyboardType: TextInputType.emailAddress,
                  label: 'Email Id'),
              AppTextField(
                  text: ref.watch(passwordProvider),
                  type: ValueType.password,
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
            onPressed: () => push(const PasswordResetPage()),
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
        onPressed: () {
          if (formKey.currentState!.validate()) {
            handleUserAction(ref, UserAction.logIn);
          }
        },
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
