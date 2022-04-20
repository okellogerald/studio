import 'package:silla_studio/manager/onboarding/providers/pages.dart';
import 'package:silla_studio/widgets/app_text_field.dart';
import '../manager/onboarding/models/user_state.dart';
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
  final formKey = GlobalKey<FormState>();

  void handleFailedState(String message) {
    final action = ref.read(userActionProvider);
    if (action.haveErrorShownBySnackBar) {
      showSnackbar(message, key: scaffoldKey);
    }
  }

  void handleSuccessState() {
    final user = ref.read(userDetailsProvider);
    showSnackbar('Password reset link has been sent to ${user.email}',
        key: scaffoldKey, isError: false);
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
        key: scaffoldKey,
        body: userState.maybeWhen(
            loading: (message) => AppLoadingIndicator(message),
            failed: (_) => _buildContent(),
            orElse: _buildContent));
  }

  Widget _buildContent() {
    return Scaffold(
      appBar: const PageAppBar(title: 'Password Reset'),
      body: Padding(
        padding: EdgeInsets.only(top: 10.dh),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.dw, right: 15.dw),
              child: const AppText(
                'Please provide your email address to which we shall send the password reset link',
                opacity: .7,
              ),
            ),
            SizedBox(height: 30.dh),
            Form(
              key: formKey,
              child: AppTextField(
                text: ref.watch(userDetailsProvider).email,
                  type: ValueType.email,
                  onChanged: (email) => updateUserDetails(ref, email: email),
                  hintText: '',
                  keyboardType: TextInputType.emailAddress,
                  label: 'Email Id'),
            ),
            AppTextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    handleUserAction(ref, UserAction.sendPasswordResetLink);
                  }
                },
                text: 'Get link',
                textColor: AppColors.onPrimary,
                backgroundColor: AppColors.primary,
                height: 50.dh,
                width: double.maxFinite,
                borderRadius: 30.dw,
                margin: EdgeInsets.only(top: 50.dh, left: 15.dw, right: 15.dw))
          ],
        ),
      ),
    );
  }
}
