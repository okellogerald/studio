import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../manager/pages.dart';
import '../manager/user_action.dart';
import '../source.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnBoardingPagesBloc, OnBoardingPagesState>(
          bloc: bloc,
          listener: (context, state) {
            final isSuccessful =
                state.maybeWhen(success: (_, __) => true, orElse: () => false);

            final password = state.supplements.password;
            final email = state.supplements.user.email;

            final isSignedIn =
                isSuccessful && password.isEmpty && email.isEmpty;
            final isReseting =
                isSuccessful && password.isEmpty && email.isNotEmpty;

            if (isSignedIn) pushAndRemoveUntil(const Homepage());
            if (isReseting) push(const PasswordResetPage());

            final error = state.maybeWhen(
                failed: (_, __, error) => error, orElse: () => null);
            if (error != null && error.isShownViaSnackBar) {
              showSnackbar(error.message, context: context);
            }
          },
          listenWhen: (_, current) => current.page == currentPage,
          buildWhen: (_, current) => current.page == currentPage,
          builder: (_, state) {
            log('building in the $currentPage');
            return state.when(
                laoding: _buildLoading,
                content: _buildContent,
                success: _buildContent,
                failed: (_, s, __) => _buildContent(_, s));
          }),
    );
  }

  Widget _buildLoading(
      Pages page, OnBoardingSupplements supp, String? message) {
    return Scaffold(body: AppLoadingIndicator(message));
  }

  Widget _buildContent(Pages page, OnBoardingSupplements supp) {
    return Scaffold(
      key: scaffoldKey,
      appBar: const PageAppBar(title: 'Welcome back to Siila !'),
      body: Padding(
        padding: EdgeInsets.only(top: 40.dh),
        child: Column(
          children: [
            AppTextField(
              error: supp.errors['email'],
              text: supp.user.email,
              onChanged: (_) => bloc.updateAttributes(email: _),
              hintText: '',
              keyboardType: TextInputType.emailAddress,
              label: 'Email Id',
            ),
            AppTextField(
              error: supp.errors['password'],
              text: supp.password,
              onChanged: (_) => bloc.updateAttributes(password: _),
              hintText: '',
              keyboardType: TextInputType.emailAddress,
              label: 'Password',
              isLoginPassword: true,
            ),
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
            onPressed: bloc.sendPasswordResetEmail,
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
        onPressed: bloc.logIn,
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
