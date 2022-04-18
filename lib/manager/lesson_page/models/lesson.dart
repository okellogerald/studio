import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silla_studio/constants.dart';
import 'package:silla_studio/manager/video/models/video_details.dart';

part 'lesson.freezed.dart';

enum LessonType { practice, learn, audio }

extension LessonTypeExtension on LessonType {
  bool get isPractice => this == LessonType.practice;
  bool get isLearn => this == LessonType.learn;
  bool get isAudio => this == LessonType.audio;
}

enum Status { completed, pending, incomplete }

extension StatusExtension on Status {
  bool get isComplete => this == Status.completed;
  bool get isPending => this == Status.pending;
  bool get isIncomplete => this == Status.incomplete || this == Status.pending;

  String get value {
    switch (this) {
      case Status.completed:
        return 'completed';
      case Status.incomplete:
        return 'incomplete';
      case Status.pending:
        return 'pending';
      default:
    }
    throw 'no matching the status keywords';
  }
}

@freezed
class Lesson with _$Lesson {
  const Lesson._();

  const factory Lesson(
      {@Default('') String id,
      @Default('') String title,
      @Default('') String topicId,
      @Default('') String topicName,
      @Default(Status.completed) Status completionStatus,
      @Default('') String description,
      @Default('') String body,
      @Default('') String thumbnailUrl,
      @Default(LessonType.learn) LessonType type,
      @Default(true) bool isPaid,
      @Default(true) bool isPublished,
      @Default(VideoDetails()) VideoDetails videoDetails}) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json,
      [VideoDetails? videoDetails]) {
    final status = json['completionStatus'];
    final type = json['lessonType'];
    return Lesson(
        id: json['id'],
        title: json['title'],
        thumbnailUrl: json['thumbnailUrl'] ?? defaultImage,
        topicId: json['topic']['id'],
        topicName: json['topic']['title'],
        type: type == 'learn'
            ? LessonType.learn
            : type == 'practice'
                ? LessonType.practice
                : LessonType.audio,
        isPaid: json['isPaid'] ?? false,
        isPublished: json['publishedStatus'] == 'published',
        videoDetails: videoDetails ?? const VideoDetails(),
        description: json['description'] ?? '',
        completionStatus: status == Status.completed.value
            ? Status.completed
            : status == Status.incomplete.value
                ? Status.incomplete
                : Status.pending,
        body: json['body'] ?? '');
  }

  bool get isComplete => completionStatus == Status.completed;

  @override
  String toString() {
    return 'Lesson(id: $id, title: $title, topicId: $topicId)';
  }
}
