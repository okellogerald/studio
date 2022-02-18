import '../source.dart';

class TopicTile extends StatelessWidget {
  const TopicTile(this.topic, {Key? key}) : super(key: key);

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    final subtitle =
        '${topic.completedLessons} / ${topic.totalLessons} videos completed';

    return AppMaterialButton(
      onPressed: () => _navigateToTopicPage(context, subtitle),
      backgroundColor: AppColors.surface,
      child: Container(
        height: 100.dh,
        padding: EdgeInsets.symmetric(horizontal: 12.dw),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.dw))),
        child: Row(
          children: [
            _buildImage(),
            SizedBox(width: 20.dw),
            _buildTitle(subtitle)
          ],
        ),
      ),
    );
  }

  _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.dw)),
      child: Image.network(topic.thumbnailUrl ?? Constants.kDefaultImage,
          width: 100.dw, height: 80.dh, fit: BoxFit.cover),
    );
  }

  _buildTitle(String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(topic.title, opacity: .7, size: 18.dw, weight: FontWeight.bold),
        SizedBox(height: 10.dh),
        AppText(subtitle, opacity: .7),
      ],
    );
  }

  _navigateToTopicPage(BuildContext context, String subtitle) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => TopicPage(
                title: topic.title, subtitle: subtitle, topicId: topic.id)));
  }
}
