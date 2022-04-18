import 'package:flutter/material.dart';
import 'package:silla_studio/widgets/app_snackbar.dart';

import '../widgets/exit_app_dialod.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void push(Widget nextPage) async => await navigatorKey.currentState
    ?.push(MaterialPageRoute(builder: (_) => nextPage));

void pop() => navigatorKey.currentState?.pop();

void pushAndRemoveUntil(Widget nextPage) =>
    navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => nextPage), (route) => false);

///uses either the scaffold key or the context to show the snackbar
void showSnackbar(String message,
    {BuildContext? context, GlobalKey<ScaffoldState>? key, bool isError = true}) {
  if (context != null) _showSnackBarCallback(context, message, isError);
  if (key != null) {
    if (key.currentState == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _showSnackBarCallback(key.currentContext!, message, isError);
      });
    } else {
      _showSnackBarCallback(key.currentContext!, message, isError);
    }
  }
}

void _showSnackBarCallback(BuildContext context, String message, bool isError) =>
    ScaffoldMessenger.of(context).showSnackBar(AppSnackBar(message, isError));

Future<bool> showExitAppDialog(BuildContext context) async {
  showDialog(
      context: context,
      builder: (context) {
        return const ExitAppDialog();
      });

  return true;
}
