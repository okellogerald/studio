import '../source.dart';

class LessonTile extends StatelessWidget {
  const LessonTile(
      {Key? key,
      required this.title,
      required this.image,
      required this.topicId,
      required this.subtitle})
      : super(key: key);

  final String title, image, subtitle, topicId;

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      onPressed: () => _navigateToTopicPage(context),
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

  void _navigateToTopicPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                TopicPage(title: title, subtitle: subtitle, topicId: topicId)));
  }
}
