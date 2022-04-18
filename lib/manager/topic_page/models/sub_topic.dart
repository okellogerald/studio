import 'package:silla_studio/manager/lesson_page/models/lesson.dart';
import 'package:silla_studio/manager/topic_page/models/topic.dart';

class SubTopic {
  final List<Lesson> lessons;
  final Topic topic;

  const SubTopic({this.lessons = const [], required this.topic});
}
