import '../source.dart';

final emptyBorder = Border.all(color: Colors.transparent, width: 0);

const bottomBorder =
    Border(bottom: BorderSide(width: 1.5, color: AppColors.divider));

final borderRadius = BorderRadius.all(Radius.circular(5.dw));
final inputBorder = OutlineInputBorder(
  borderSide: const BorderSide(width: 0.0, color: Colors.transparent),
  borderRadius: borderRadius,
);

final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.dw)),
    borderSide: const BorderSide(width: 1.2, color: AppColors.error));

final hintStyle = TextStyle(
  color: AppColors.onBackground.withOpacity(.5),
  fontSize: 16.dw,
  fontWeight: FontWeight.w100,
);

final valueStyle = TextStyle(
  color: AppColors.onBackground,
  fontSize: 16.dw,
  fontWeight: FontWeight.w500,
);
