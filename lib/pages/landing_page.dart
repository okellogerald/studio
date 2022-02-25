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
          _buildLogo(),
          _buildValueProposition(),
          _buildActions(),
        ],
      ),
    ));
  }

  _buildLogo() {
    return Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/logo.png',
          color: AppColors.primary,
          height: 100.dh,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  _buildValueProposition() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.dw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const AppText(
              'Spreading harmony through art',
              style: TextStyle(
                  color: AppColors.primaryVariant, fontStyle: FontStyle.italic),
            ),
            AppDivider(
                height: 2,
                margin: EdgeInsets.symmetric(horizontal: 80.dw),
                color: AppColors.divider.shade300),
            const AppText(
                'Art is something that makes you breath with a different kind of happiness',
                alignment: TextAlign.center,
                opacity: .7),
            AppText('Let\'s learn an art today !',
                size: 22.dw, weight: FontWeight.bold),
          ],
        ),
      ),
    );
  }

  _buildActions() {
    return Expanded(
      flex: 2,
      child: Builder(builder: (context) {
        return Column(
          children: [
            SizedBox(height: 40.dh),
            AppTextButton(
              onPressed: () => WelcomePage.navigateTo(context),
              text: 'GET STARTED',
              height: 50.dh,
              backgroundColor: AppColors.primary,
              textColor: AppColors.onPrimary,
              margin: EdgeInsets.symmetric(horizontal: 15.dw),
              borderRadius: 30.dw,
            ),
            AppTextButton(
              onPressed: () => LogInPage.navigateTo(context),
              text: 'Already have an account ?',
              height: 50.dh,
              textColor: AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 10.dw),
              margin: EdgeInsets.only(left: 15.dw, right: 15.dw, top: 15.dh),
              borderRadius: 30.dw,
            ),
          ],
        );
      }),
    );
  }
}
