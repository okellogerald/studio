import '../source.dart';

class FailedStateWidget extends StatelessWidget {
  const FailedStateWidget(this.message,
      {required this.tryAgainCallback, required this.title, key})
      : super(key: key);
  final String message;
  final String title;
  final VoidCallback tryAgainCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.dw),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(title, size: 22.dw),
          SizedBox(height: 20.dh),
          AppText(message),
          AppTextButton(
            onPressed: tryAgainCallback,
            text: 'Try Again',
            height: 40.dh,
            margin: EdgeInsets.only(top: 20.dh),
          )
        ],
      ),
    );
  }
}
