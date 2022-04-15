import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:silla_studio/manager/video/providers.dart';
import 'package:silla_studio/manager/video/video_controls_actions_handler.dart';

import '../source.dart';

class LessonTile extends ConsumerWidget {
  const LessonTile(this.lesson, this.lessonsIdList, {Key? key})
      : super(key: key);

  final Lesson lesson;
  final List<String> lessonsIdList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLearning = lesson.type == LessonType.learn;
    final subtitle =
        '${lesson.topicName} - ' + (isLearning ? 'LEARN' : 'PRACTICE');

    return AppMaterialButton(
      onPressed: lesson.isPaid
          ? () {}
          : () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => LessonPage(lesson.id, lessonsIdList)));
              log('I have popped to the previois screen with the value');
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

  _buildImage(String completionStatus) {
    final isComplete = completionStatus == Status.completed;
    final isPending = completionStatus == Status.pending;

    return SizedBox(
      height: 80.dh,
      width: 100.dw,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.dw)),
            child: Image.network(lesson.thumbnailUrl ?? Constants.kDefaultImage,
                width: 100.dw, height: 80.dh, fit: BoxFit.cover),
          ),
          isComplete
              ? const CheckMark()
              : isPending
                  ? const Icon(Icons.pause_circle, color: AppColors.primary)
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
