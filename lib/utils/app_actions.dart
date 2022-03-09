import '../source.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void push(Widget nextPage) async => await navigatorKey.currentState
    ?.push(MaterialPageRoute(builder: (_) => nextPage));

void pop() => navigatorKey.currentState?.pop();

void pushAndRemoveUntil(Widget nextPage) =>
    navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => nextPage), (route) => false);

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      dismissDirection: DismissDirection.none,
      backgroundColor: AppColors.background,
      content: AppSnackBarContent(message)));
}
