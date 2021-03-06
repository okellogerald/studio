import 'source.dart';

class CompletionProgressBar extends StatelessWidget {
  const CompletionProgressBar(this.value, {Key? key}) : super(key: key);

  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.dw,
      height: 15.dh,
      child: CustomPaint(painter: BarPainter(value)),
    );
  }
}

class BarPainter extends CustomPainter {
  BarPainter(this.value);
  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final rect = Rect.fromLTWH(0, 0, width, 15.dh);
    final rect2 = Rect.fromLTWH(0, 0, width * value, 15.dh);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(5.dw));
    final rrect2 = RRect.fromRectAndRadius(rect2, Radius.circular(5.dw));

    final paint = Paint()
      ..color = AppColors.accent
      ..strokeCap = StrokeCap.round;
    final linePaint = Paint()
      ..color = AppColors.onPrimary
      ..strokeCap = StrokeCap.round;

    canvas.drawRRect(rrect, linePaint);
    canvas.drawRRect(rrect2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
