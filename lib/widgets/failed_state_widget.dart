import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:silla_studio/manager/user_action.dart';
import '../errors/error_handler.dart';
import 'app_text_button.dart';
import 'source.dart';

class FailedStateWidget extends StatelessWidget {
  const FailedStateWidget(this.message, {key}) : super(key: key);
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer(builder: (context, ref, child) {
        final failureMessage = getUserActionFailureTitle(ref);
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
                  onPressed: () {
                    final userAction = ref.read(userActionProvider);
                    handleUserAction(ref, userAction);
                  },
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
