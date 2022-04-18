import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic.freezed.dart';

@freezed
class Topic with _$Topic{
  const factory Topic(
      {@Default('') String id,
      @Default('') String title,
      String? description,
      String? thumbnailUrl,
      String? parentID,
      @Default(0) int totalLessons,
      @Default(0) int completedLessons,
      @Default(false) bool isPublished}) = _Topic;

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnailUrl: json['thumbnailUrl'],
      parentID: json['parentID'],
      isPublished: json['publishedStatus'] == 'published',
      totalLessons: json['lessonsCount'],
      completedLessons: json['completedLessonsCount'],
    );
  }
}
