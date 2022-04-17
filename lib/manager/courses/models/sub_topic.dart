import '../../../models/source.dart';

class SubTopic {
  final List<Lesson> lessons;
  final Topic topic;

  const SubTopic({this.lessons = const [], required this.topic});
}
