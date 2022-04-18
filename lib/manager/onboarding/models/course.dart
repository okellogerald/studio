import 'grade.dart';

class Course {
  final String type;
  final bool isPublished;
  final String title;
  final int id;
  final List<Grade> gradeList;
  final List levelList;

  Course(
      {required this.type,
      required this.isPublished,
      required this.title,
      required this.levelList,
      required this.gradeList,
      required this.id});

  factory Course.fromJson(Map<String, dynamic> json) {
    final gradeList = <Grade>[];
    for (var grade in json['grades']) {
      gradeList.add(Grade(id: grade['id'], title: grade['title']));
    }

    return Course(
      type: json['courseType'],
      isPublished: json['publishedStatus'] == 'published',
      title: json['title'],
      levelList: json['levels'],
      gradeList: gradeList,
      id: json['id'],
    );
  }

  @override
  String toString() {
    return 'Course(id: $id, type: $type, isPublished: $isPublished, title: $title, levelList: $levelList, gradeList: $gradeList)';
  }
}
