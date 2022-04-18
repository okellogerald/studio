import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:silla_studio/constants.dart';
import 'package:silla_studio/pages/landing_page.dart';
import 'package:silla_studio/theme/app_theme.dart';
import 'package:silla_studio/utils/navigation_logic.dart';
import 'package:silla_studio/widgets/screen_size_init.dart';
import 'pages/homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final noAccountYet =
      Hive.box(kUserDataBox).get(kUserData) == null;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenSizeInit(
        designSize: const Size(411.4, 866.3),
        child: MaterialApp(
          title: 'Siila',
          navigatorKey: navigatorKey,
          theme: AppTheme.themeData(),
          debugShowCheckedModeBanner: false,
          home: noAccountYet ? const LandingPage() : const Homepage(),
        ),
      ),
    );
  }
}
