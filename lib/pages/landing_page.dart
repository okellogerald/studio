import '../source.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextButton(
          onPressed: () => WelcomePage.navigateTo(context),
          text: 'Get Started',
          height: 60.dh,
          width: 200.dw,
        ),
        SizedBox(height: 40.dh),
        AppTextButton(
          onPressed: () {},
          text: 'Log In',
          height: 40.dh,
          isFilled: false,
          textColor: AppColors.onBackground,
        ),
      ],
    ));
  }
}
