import 'dart:developer';

enum LessonType { practice, learn }

class Lesson {
  final String id, title, videoTime, topicId, topicName;
  String? thumbnailUrl;
  final LessonType type;
  final bool? isPaid, isPublished;

  Lesson(
      {required this.id,
      required this.title,
      required this.thumbnailUrl,
      required this.videoTime,
      required this.topicId,
      required this.topicName,
      required this.type,
      required this.isPaid,
      required this.isPublished});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
        id: json['id'],
        title: json['title'],
        thumbnailUrl: json['thumbnailUrl'] ?? defaultImage,
        videoTime: json['videoTime'],
        topicId: json['topic']['id'],
        topicName: json['topic']['title'],
        type: json['lessonType'] == 'learn'
            ? LessonType.learn
            : LessonType.practice,
        isPaid: json['ispaid'],
        isPublished: json['publishedStatus'] == 'published');
  }

  factory Lesson.empty() => Lesson(
      id: '',
      title: '',
      thumbnailUrl: '',
      videoTime: '',
      topicId: '',
      topicName: '',
      type: LessonType.learn,
      isPaid: false,
      isPublished: false);

  static const defaultImage =
      'https://images.pexels.com/photos/3949699/pexels-photo-3949699.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
}