import '../manager/video/models/video_details.dart';
import '../source.dart';

part 'lesson.freezed.dart';

enum LessonType { practice, learn }

enum Status { completed, pending, incomplete }

extension StatusExtension on Status {
  bool get isComplete => this == Status.completed;
  bool get isPending => this == Status.pending;
  bool get isIncomplete => this == Status.incomplete;

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
    return Lesson(
        id: json['id'],
        title: json['title'],
        thumbnailUrl: json['thumbnailUrl'] ?? defaultImage,
        topicId: json['topic']['id'],
        topicName: json['topic']['title'],
        type: json['lessonType'] == 'learn'
            ? LessonType.learn
            : LessonType.practice,
        isPaid: json['isPaid'] ?? false,
        isPublished: json['publishedStatus'] == 'published',
        videoDetails: videoDetails ?? const VideoDetails(),
        description: json['description'] ?? '',
        completionStatus: status == Status.completed.value
            ? Status.completed
            : status == Status.incomplete
                ? Status.incomplete
                : Status.pending,
        body: json['body'] ?? '');
  }

  bool get isComplete => completionStatus == Status.completed;

  @override
  String toString() {
    return 'Lesson(id: $id, title: $title, body: $body)';
  }
}
