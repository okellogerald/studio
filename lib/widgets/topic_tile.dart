import '../source.dart';

class TopicTile extends StatelessWidget {
  const TopicTile(this.topic, {Key? key}) : super(key: key);

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    final subtitle =
        '${topic.completedLessons} / ${topic.totalLessons} videos completed';

    return AppMaterialButton(
      onPressed: () => _navigateToTopicPage(context, topic),
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
            _buildTitle(subtitle),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.chevron_right,
                      size: 20.dw,
                      color: AppColors.secondary.withOpacity(.7),
                    ))),
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
        AppText(topic.title, size: 18.dw, weight: FontWeight.w700),
        SizedBox(height: 5.dh),
        AppText(subtitle, opacity: .7),
      ],
    );
  }

  _navigateToTopicPage(BuildContext context, Topic topic) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => TopicPage(topic: topic)));
  }
}
