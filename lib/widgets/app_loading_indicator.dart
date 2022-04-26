import 'package:silla_studio/widgets/source.dart';

class AppLoadingIndicator extends StatelessWidget {
  final bool isUsingScaffold;
  final String? loadingMessage;

  const AppLoadingIndicator.withScaffold(
      [String? message, bool? withJumpingDots, Key? key])
      : isUsingScaffold = true,
        loadingMessage = message,
        super(key: key);

  const AppLoadingIndicator([String? message, bool? withJumpingDots, Key? key])
      : isUsingScaffold = false,
        loadingMessage = message,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return isUsingScaffold ? Scaffold(body: _child()) : _child();
  }

  _child() {
    final hasMessage = loadingMessage != null;
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        SizedBox(height: hasMessage ? 20.dh : 0),
        hasMessage
            ? AppText(loadingMessage!, color: AppColors.onPrimary, size: 15.dw)
            : Container()
      ],
    ));
  }
}
