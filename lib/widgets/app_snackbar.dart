import 'source.dart';

class AppSnackBar extends SnackBar {
  final String message;
  final bool isError;
  AppSnackBar(this.message, this.isError, {Key? key})
      : super(
            key: key,
            content: AppText(message,
                alignment: TextAlign.center,
                color: isError ? AppColors.onError : AppColors.onBackground,
                size: 14.dw));

  @override
  Color? get backgroundColor =>
      isError ? AppColors.error : const Color(0xff32cd32);

  @override
  SnackBarBehavior? get behavior => SnackBarBehavior.floating;

  @override
  ShapeBorder? get shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.dh));
}
