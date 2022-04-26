import 'package:silla_studio/pages/source.dart';
import '../manager/onboarding/models/user_state.dart';
import '../manager/onboarding/providers/user_notifier.dart';
import 'homepage.dart';
import 'landing_page.dart';

class FirstPage extends ConsumerStatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  ConsumerState<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends ConsumerState<FirstPage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(userNotifierProvider.notifier).autoLogIn();
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    ref.listen(userNotifierProvider, (UserState? previous, UserState? next) {
      next!.maybeWhen(
          success: () => pushAndRemoveUntil(const Homepage()),
          failed: (_) => pushAndRemoveUntil(const LandingPage()),
          orElse: () {});
    });
    return const AppLoadingIndicator.withScaffold('Logging in');
  }
}
