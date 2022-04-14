import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../source.dart';

class AppImage extends StatelessWidget {
  final String imageUrl;
  final double width, height;
  final double? radius;
  final bool withBorders;
  final Color placeholderColor;

  const AppImage(
      {Key? key,
      required this.imageUrl,
      this.radius,
      this.placeholderColor = AppColors.secondary,
      this.height = 180,
      this.withBorders = false,
      this.width = 300})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
        child: CachedNetworkImage(
          width: width,
          height: height,
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, __) => Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: placeholderColor,
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 0))),
              child: Icon(FontAwesomeIcons.image,
                  size: 25.dw, color: AppColors.onSecondary)),
        ));
  }
}
