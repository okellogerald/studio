import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'source.dart';
class ScreenSizeInit extends ConsumerWidget {
  const ScreenSizeInit({required this.child, required this.designSize, key})
      : super(key: key);

  final Size designSize;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(builder: (context, orientation) {
      return LayoutBuilder(builder: (context, constraints) {
        final isPortrait = orientation == Orientation.portrait;

        if (constraints.maxWidth > 0) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          final screenSize = isPortrait
              ? Size(screenWidth, screenHeight)
              : Size(screenHeight, screenWidth);
          ScreenSizeConfig.init(designSize, screenSize, ref, orientation);
          return child;
        }
        return Container();
      });
    });
  }
}
