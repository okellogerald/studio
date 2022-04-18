import 'package:silla_studio/manager/homepage/models/general_info.dart';
import 'package:silla_studio/manager/lesson_page/models/lesson.dart';
import 'package:silla_studio/manager/topic_page/models/topic.dart';

class CourseOverview {
  final GeneralInfo generalInfo;
  final Lesson currentLesson;
  final List<Topic> topicList;

  const CourseOverview(
      {required this.generalInfo,
      required this.currentLesson,
      required this.topicList});

  factory CourseOverview.empty() => CourseOverview(
      generalInfo: GeneralInfo.empty(),
      currentLesson: const Lesson(),
      topicList: []);
}
