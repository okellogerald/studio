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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const AppText(
            'Spreading harmony through art',
            style: TextStyle(
                color: AppColors.primary, fontStyle: FontStyle.italic),
          ),
          AppDivider(
              height: 2,
              margin: EdgeInsets.symmetric(horizontal: 80.dw),
              color: AppColors.divider.shade300),
          const AppText(
              'Art is something that makes you breath with a different kind of happiness',
              alignment: TextAlign.center,
              weight: FontWeight.bold),
          AppText('Let\'s learn an art today !',
              size: 22.dw, weight: FontWeight.bold),
        ],
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
              width: 230.dw,
              backgroundColor: AppColors.primary,
              textColor: AppColors.onPrimary,
            ),
            SizedBox(height: 30.dh),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppText('Already have an account ?'),
                AppTextButton(
                  onPressed: () => LogInPage.navigateTo(context),
                  text: 'LOG IN',
                  textColor: AppColors.primary,
                  margin: EdgeInsets.only(left: 15.dw, right: 20.dw),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
