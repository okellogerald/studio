import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../theme/app_colors.dart';
import '../widgets/app_text.dart';

class AboutPage extends StatefulWidget {
  const AboutPage(this.url, {required this.title, Key? key}) : super(key: key);
  final String url, title;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.onPrimary,
          elevation: 0,
          title: AppText(widget.title),
        ),
        body: WebView(initialUrl: widget.url));
  }
}
