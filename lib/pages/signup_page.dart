import '../source.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static navigateTo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const SignUpPage()));
  }

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final OnBoardingPagesBloc bloc;

  @override
  void initState() {
    bloc = Provider.of<OnBoardingPagesBloc>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
          title: 'One Last Thing!',
          subtitle: 'Let\'s create an account for you.'),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocConsumer<OnBoardingPagesBloc, OnBoardingPagesState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccess =
              state.maybeWhen(success: (_) => true, orElse: () => false);

          if (isSuccess) {
            Homepage.navigateTo(context);
          }

          final error = state.maybeWhen(
              failed: (_, message) => message, orElse: () => null);
          if (error != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: AppText(error)));
          }
        },
        builder: (_, state) {
          return state.when(
              laoding: _buildLoading,
              content: _buildContent,
              success: _buildContent,
              failed: (s, _) => _buildContent(s));
        });
  }

  Widget _buildLoading(OnBoardingSupplements supp, String? message) {
    return AppLoadingIndicator(message);
  }

  Widget _buildContent(OnBoardingSupplements supp) {
    return Padding(
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
          ),
          AppTextField(
            error: supp.errors['confirm_password'],
            text: supp.confirmationPassword,
            onChanged: (_) => bloc.updateAttributes(confirmationPassword: _),
            hintText: '',
            keyboardType: TextInputType.emailAddress,
            label: 'Confirm Passowrd',
            isPassword: true,
          ),
          _buildGetStartedButton()
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
            onPressed: bloc.signUp,
            text: 'Get Started',
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
