import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silla_studio/manager/video/video_controls_actions_handler.dart';
import 'package:silla_studio/utils/navigation_logic.dart';
import 'package:silla_studio/widgets/app_image.dart';

import '../constants.dart';
import '../manager/lesson_page/models/lesson.dart';
import '../pages/lesson_page.dart';
import 'app_material_button.dart';
import 'check_mark.dart';
import 'source.dart';

class LessonTile extends ConsumerWidget {
  const LessonTile(this.lesson, {Key? key}) : super(key: key);

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLearning = lesson.type == LessonType.learn;
    final isPractice = lesson.type == LessonType.practice;
    final subtitle = '${lesson.topicName} - ' +
        (isLearning
            ? 'LEARN'
            : isPractice
                ? 'PRACTICE'
                : 'AUDIO');

    return AppMaterialButton(
      onPressed: () async {
        if (lesson.isPaid) {
          showSnackbar('This lesson is only available for paid users',
              context: context);
          return;
        }
        //todo handle the markAsComplete vs Incomplete
        await Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LessonPage(lesson)));
        handleVideoControllerOnPop(ref);
      },
      backgroundColor: AppColors.surface,
      child: Container(
        height: 100.dh,
        padding: EdgeInsets.symmetric(horizontal: 12.dw),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.dw))),
        child: Row(
          children: [
            _buildImage(lesson.completionStatus),
            SizedBox(width: 20.dw),
            _buildTitle(subtitle, lesson),
            _buildIsPaidIcon(),
          ],
        ),
      ),
    );
  }

  _buildImage(Status status) {
    return SizedBox(
      height: 80.dh,
      width: 100.dw,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          AppImage(
              imageUrl: lesson.thumbnailUrl.isEmpty
                  ? defaultImage
                  : lesson.thumbnailUrl,
              width: 100.dw,
              radius: 8.dw,
              height: 80.dh),
          status.isComplete
              ? const CheckMark()
              : status.isPending
                  ? const Icon(Icons.pause_circle, color: AppColors.onPrimary)
                  : Container()
        ],
      ),
    );
  }

  _buildTitle(String subtitle, Lesson lesson) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(lesson.title, color: AppColors.primaryVariant),
        SizedBox(height: 5.dh),
        AppText(subtitle, opacity: .7, size: 14.dw),
      ],
    );
  }

  _buildIsPaidIcon() {
    final isPaid = lesson.isPaid;
    return Expanded(
        child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
                isPaid ? FontAwesomeIcons.lock : FontAwesomeIcons.angleRight,
                size: 20.dw,
                color: AppColors.secondary.withOpacity(1))));
  }
}
