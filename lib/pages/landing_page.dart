import '../source.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          AppTextButton(
            onPressed: () => WelcomePage.navigateTo(context),
            text: 'Get Started',
            height: 50.dh,
            width: 200.dw,
            backgroundColor: AppColors.primary,
            textColor: AppColors.onPrimary,
          ),
          SizedBox(height: 30.dh),
          AppTextButton(
            onPressed: () => LogInPage.navigateTo(context),
            text: 'Log In',
            height: 50.dh,
            width: 200.dw,
            textColor: AppColors.onBackground,
            backgroundColor: AppColors.surface,
          ),
      ],
    ),
        ));
  }
}
