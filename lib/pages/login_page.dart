import '../source.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  static navigateTo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const LogInPage()));
  }

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late final OnBoardingPagesBloc bloc;

  @override
  void initState() {
    bloc = Provider.of<OnBoardingPagesBloc>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingPagesBloc, OnBoardingPagesState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccessful =
              state.maybeWhen(success: (_) => true, orElse: () => false);

          final password = state.supplements.password;
          final email = state.supplements.user.email;
          final isSignedIn = isSuccessful && password.isEmpty && email.isEmpty;
          final isReseting =
              isSuccessful && password.isEmpty && email.isNotEmpty;
          if (isSignedIn) _navigateToHomepage();
          if (isReseting) PasswordResetPage.navigateTo(context);

          final error = state.maybeWhen(
              failed: (_, message) => message, orElse: () => null);
          if (error != null) _showError(error);
        },
        builder: (_, state) {
          return state.when(
              laoding: _buildLoading,
              content: _buildContent,
              success: _buildContent,
              failed: (s, _) => _buildContent(s));
        });
  }

  void _navigateToHomepage() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const Homepage()), (route) => false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: AppText(message,
            style: Theme.of(context)
                .snackBarTheme
                .contentTextStyle!
                .copyWith(fontSize: 14.dw))));
  }

  Widget _buildLoading(OnBoardingSupplements supp, String? message) {
    return Scaffold(body: AppLoadingIndicator(message));
  }

  Widget _buildContent(OnBoardingSupplements supp) {
    return Scaffold(
      appBar: const PageAppBar(title: 'Welcome back to Siila!'),
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
              isPassword: true,
              isLoginPassword: true,
            ),
            _buildForgotPassword(),
            _buildGetStartedButton()
          ],
        ),
      ),
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

  _buildGetStartedButton() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppTextButton(
            onPressed: bloc.logIn,
            text: 'LOG IN',
            textColor: AppColors.onPrimary,
            backgroundColor: AppColors.primary,
            height: 50.dh,
            width: 200.dw,
            margin: EdgeInsets.only(bottom: 40.dh, right: 15.dw),
          ),
        ],
      ),
    );
  }
}
