import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/theme/app_theme.dart';
import 'package:silla_studio/utils/navigation_logic.dart';
import 'package:silla_studio/widgets/screen_size_init.dart';
import 'pages/first_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          home: const FirstPage(),
        ),
      ),
    );
  }
}
