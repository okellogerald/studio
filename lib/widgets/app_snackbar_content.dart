import 'source.dart';

class AppSnackBarContent extends StatelessWidget {
  const AppSnackBarContent(this.message, {Key? key}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenSizeConfig.getFullWidth,
        height: 70.dh,
        padding: EdgeInsets.symmetric(horizontal: 5.dw),
        margin: EdgeInsets.all(10.dw),
        alignment: Alignment.center,
        decoration:
            BoxDecoration(color: AppColors.error, borderRadius: borderRadius),
        child: AppText(message,
            alignment: TextAlign.center,
            style: Theme.of(context)
                .snackBarTheme
                .contentTextStyle!
                .copyWith(fontSize: 14.dw)));
  }
}
