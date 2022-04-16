import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../manager/user/user_actions.dart';
import '../source.dart' hide Consumer;

class FailedStateWidget extends StatelessWidget {
  const FailedStateWidget(this.message, {required this.tryAgainCallback, key})
      : super(key: key);
  final String? message;
  final VoidCallback tryAgainCallback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(builder: (context, ref, child) {
        final failureMessage = getUserActionFailureMessage(ref);
        return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 30.dh),
            color: Colors.grey.withOpacity(.4),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Lottie.asset('assets/images/404.json',
                  height: 200.dh, fit: BoxFit.contain),
              AppText(failureMessage, size: 15.dw),
              SizedBox(height: 25.dh),
              message == null
                  ? Container()
                  : AppText(message!, opacity: .7, size: 14.dw),
              AppTextButton(
                  onPressed: () => tryAgainCallback(),
                  textColor: AppColors.onPrimary,
                  text: 'TRY AGAIN',
                  backgroundColor: AppColors.primary,
                  height: 50.dh,
                  margin: EdgeInsets.only(top: 25.dw))
            ]));
      }),
    );
  }
}
