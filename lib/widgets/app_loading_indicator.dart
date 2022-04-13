import '../source.dart';

class AppLoadingIndicator extends StatelessWidget {
  final String? message;
  final Color? textColor;
  const AppLoadingIndicator(this.message, {this.textColor, key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: message != null
            ? Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: 20.dh),
                  AppText(message!, color: textColor ?? AppColors.onBackground)
                ],
              )
            : const CircularProgressIndicator());
  }
}
