import 'package:hive/hive.dart';
import 'source.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final noAccountYet =
      Hive.box(Constants.kUserDataBox).get(Constants.kUserData) == null;

  @override
  Widget build(BuildContext context) {
    return ScreenSizeInit(
      designSize: const Size(411.4, 866.3),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Siila',
        theme: AppTheme.themeData(),
        home: noAccountYet ? const LandingPage() : const Homepage(),
      ),
    );
  }
}
