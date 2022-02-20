import '../source.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar(this.name, {this.size, Key? key}) : super(key: key);

  final String name;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 45.dw,
      width: size ?? 45.dw,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: AppColors.primaryVariant),
      child: AppText(
        name.toString().substring(0, 1),
        weight: FontWeight.bold,
        size: 25.dw,
        opacity: .7,
      ),
    );
  }
}
