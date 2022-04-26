import '../constants.dart';
import 'source.dart';

class AppText extends StatelessWidget {
  const AppText(this.data,
      {this.color,
      key,
      this.alignment,
      this.size,
      this.weight,
      this.opacity,
      this.style})
      : super(key: key);

  final String data;
  final Color? color;
  final double? size, opacity;
  final FontWeight? weight;
  final TextAlign? alignment;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(data,
        textAlign: alignment ?? TextAlign.start,
        style: style ??
            TextStyle(
                fontFamily: kFontFam,
                fontWeight: weight ?? FontWeight.w500,
                fontSize: size ?? 15.dw,
                color: (color ?? AppColors.onBackground)
                    .withOpacity(opacity ?? 1)));
  }
}
