import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silla_studio/constants.dart';
import '../manager/topic_page/models/topic.dart';
import '../pages/topic_page.dart';
import '../utils/navigation_logic.dart';
import 'app_material_button.dart';
import 'source.dart';
import 'app_image.dart';

class TopicTile extends StatelessWidget {
  const TopicTile(this.topic, {Key? key}) : super(key: key);

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    final subtitle =
        '${topic.completedLessons} / ${topic.totalLessons} videos completed';

    return AppMaterialButton(
      onPressed: () => push(TopicPage(topic: topic)),
      backgroundColor: AppColors.surface,
      child: Container(
        height: 100.dh,
        padding: EdgeInsets.symmetric(horizontal: 12.dw),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.dw))),
        child: Row(
          children: [
            AppImage(
                imageUrl: topic.thumbnailUrl ?? defaultImage2,
                width: 100.dw,
                radius: 8.dw,
                height: 80.dh),
            SizedBox(width: 20.dw),
            _buildTitle(subtitle),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(FontAwesomeIcons.angleRight,
                        size: 20.dw, color: AppColors.onBackground2))),
          ],
        ),
      ),
    );
  }

  _buildTitle(String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(topic.title, color: AppColors.primary),
        SizedBox(height: 8.dh),
        AppText(subtitle, opacity: .7, size: 14.dw),
      ],
    );
  }
}
