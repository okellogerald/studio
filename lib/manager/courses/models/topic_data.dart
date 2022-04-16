import '../../../models/source.dart';

class TopicData {
  final List<Lesson> lessons;
  final List<Topic> subtopics;

  const TopicData({this.lessons = const [], this.subtopics = const []});
}
