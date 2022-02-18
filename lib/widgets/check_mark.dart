import '../source.dart';

class CheckMark extends StatelessWidget {
  const CheckMark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.dw, right: 2.dw),
      child: const Icon(Icons.check_circle, color: AppColors.accent),
    );
  }
}
