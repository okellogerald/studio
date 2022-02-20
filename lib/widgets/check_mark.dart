import '../source.dart';

class CheckMark extends StatelessWidget {
  const CheckMark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.check_circle, color: AppColors.accent);
  }
}
