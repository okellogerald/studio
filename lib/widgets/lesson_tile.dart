import '../source.dart';

class LessonTile extends StatelessWidget {
  const LessonTile(
      {Key? key,
      required this.title,
      required this.image,
      required this.onPressed,
      required this.subtitle})
      : super(key: key);

  final String title, image, subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      onPressed: onPressed,
      backgroundColor: AppColors.surface,
      child: Container(
        height: 100.dh,
        padding: EdgeInsets.symmetric(horizontal: 12.dw),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.dw))),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.dw)),
              child: Image.network(image,
                  width: 100.dw, height: 80.dh, fit: BoxFit.cover),
            ),
            SizedBox(width: 20.dw),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(title,
                    opacity: .7, size: 18.dw, weight: FontWeight.bold),
                SizedBox(height: 10.dh),
                AppText(subtitle, opacity: .7),
              ],
            )
          ],
        ),
      ),
    );
  }
}
