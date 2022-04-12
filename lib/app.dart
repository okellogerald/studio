import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'pages/video_page.dart';
import 'source.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final noAccountYet =
      Hive.box(Constants.kUserDataBox).get(Constants.kUserData) == null;

  @override
  Widget build(BuildContext context) {
    return ScreenSizeInit(
      designSize: const Size(411.4, 866.3),
      child: ProviderScope(
        child: MaterialApp(
          title: 'Siila',
          navigatorKey: navigatorKey,
          theme: AppTheme.themeData(),
          debugShowCheckedModeBanner: false,
          home:
              const VideoPage() /* noAccountYet ? const LandingPage() : const Homepage() */,
        ),
      ),
    );
  }
}
