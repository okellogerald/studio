import '../source.dart';

class AppSnackBar extends SnackBar {
  final String message;
  AppSnackBar(this.message, {Key? key})
      : super(
            key: key,
            content: AppText(message,
                alignment: TextAlign.center,
                color: AppColors.onError,
                size: 14.dw));

  @override
  Color? get backgroundColor => AppColors.error;

  @override
  SnackBarBehavior? get behavior => SnackBarBehavior.floating;

  @override
  ShapeBorder? get shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.dh));
}
