import 'package:silla_studio/models/general_info.dart';

import '../../../models/lesson.dart';
import '../../../models/topic.dart';

class CourseOverview {
  final GeneralInfo generalInfo;
  final Lesson currentLesson;
  final List<Topic> topicList;

  const CourseOverview(
      {required this.generalInfo,
      required this.currentLesson,
      required this.topicList});
}
