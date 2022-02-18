import '../source.dart';

class LessonTile extends StatelessWidget {
  const LessonTile(this.lesson, {Key? key}) : super(key: key);

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final isLearning = lesson.type == LessonType.learn;
    final subtitle =
        '${lesson.topicName} - ' + (isLearning ? 'LEARN' : 'PRACTICE');

    return AppTextButton(
      onPressed: lesson.isPaid
          ? () {}
          : () => _navigateToLessonPage(context, lesson.id),
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
            _buildTitle(subtitle),
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

  _buildTitle(String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(lesson.title,
            opacity: .7, size: 18.dw, weight: FontWeight.bold),
        SizedBox(height: 10.dh),
        AppText(subtitle, opacity: .7),
      ],
    );
  }

  _buildIsPaidIcon() {
    final isPaid = lesson.isPaid;
    return Expanded(
        child: Align(
            alignment: Alignment.centerRight,
            child: Icon(isPaid ? Icons.lock_outlined : Icons.chevron_right)));
  }

  _navigateToLessonPage(BuildContext context, String id) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => LessonPage(id)));
  }
}
