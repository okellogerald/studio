import 'package:flutter/material.dart';
import 'package:silla_studio/widgets/app_snackbar.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void push(Widget nextPage) async => await navigatorKey.currentState
    ?.push(MaterialPageRoute(builder: (_) => nextPage));

void pop() => navigatorKey.currentState?.pop();

void pushAndRemoveUntil(Widget nextPage) =>
    navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => nextPage), (route) => false);

///uses either the scaffold key or the context to show the snackbar
void showSnackbar(String message,
    {BuildContext? context, GlobalKey<ScaffoldState>? key}) {
  if (context != null) _showSnackBarCallback(context, message);
  if (key != null) {
    if (key.currentState == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _showSnackBarCallback(key.currentContext!, message);
      });
    } else {
      _showSnackBarCallback(key.currentContext!, message);
    }
  }
}

void _showSnackBarCallback(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(message));
