import '../source.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  static navigateTo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const PasswordResetPage()));
  }

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  late final OnBoardingPagesBloc bloc;

  @override
  void initState() {
    bloc = Provider.of<OnBoardingPagesBloc>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnBoardingPagesBloc, OnBoardingPagesState>(
          bloc: bloc,
          listener: (context, state) {
            final isSignedIn =
                state.maybeWhen(success: (_) => true, orElse: () => false);
            if (isSignedIn) push(const LogInPage());

            final error = state.maybeWhen(
                failed: (_, message) => message, orElse: () => null);
            if (error != null) showSnackbar(error, context: context);
          },
          builder: (_, state) {
            return state.when(
                laoding: _buildLoading,
                content: _buildContent,
                success: _buildContent,
                failed: (s, _) => _buildContent(s));
          }),
    );
  }

  Widget _buildLoading(OnBoardingSupplements supp, String? message) {
    return Scaffold(body: AppLoadingIndicator(message));
  }

  Widget _buildContent(OnBoardingSupplements supp) {
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
            _buildResendCode(supp.user.email),
          ],
        ),
      ),
    );
  }

  _buildResendCode(String email) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Email sent to $email'),
        SizedBox(height: 10.dh),
        Row(
          children: [
            const AppText('Didn\'t get it ?'),
            AppTextButton(
              onPressed: () {
                Navigator.pop(context);
                bloc.sendPasswordResetEmail();
              },
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
