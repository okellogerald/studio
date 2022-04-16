import '../manager/user/user_actions.dart';
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
  final currentPage = Pages.signUpPage;

  @override
  void initState() {
    bloc = Provider.of<OnBoardingPagesBloc>(context, listen: false);
    bloc.init(currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnBoardingPagesBloc, OnBoardingPagesState>(
          bloc: bloc,
          listener: (context, state) {
            final isSuccess =
                state.maybeWhen(success: (_, __) => true, orElse: () => false);
            if (isSuccess) pushAndRemoveUntil(const Homepage());

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
      appBar: const PageAppBar(
          title: 'One Last Thing !',
          subtitle: 'Let\'s create an account for you.'),
      body: ListView(
        padding: EdgeInsets.only(top: 40.dh),
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
        onPressed: bloc.signUp,
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
