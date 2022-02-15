class Topic {
  final String id, title;
  String? description, thumbnailUrl, parentID;
  final int? totalLessons, completedLessons;
  final bool isPublished;

  Topic({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.parentID,
    required this.totalLessons,
    required this.completedLessons,
    required this.isPublished,
  });

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

  static const defaultImage =
      'https://images.pexels.com/photos/5346459/pexels-photo-5346459.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
}
