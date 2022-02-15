import '../source.dart';

part 'user_data.freezed.dart';

@freezed
class UserData with _$UserData {
  const UserData._();

  const factory UserData(
      {required DateTime dateOfBirth,
      required String email,
      required String name,
      required String gender,
      required int courseId,
      required String level,
      required int gradeId}) = _UserData;

  factory UserData.empty() => UserData(
        name: '',
        email: '',
        gender: 'Male',
        level: '',
        courseId: 0,
        gradeId: 0,
        dateOfBirth: DateTime.now(),
      );

  String get getFormattedDateOfBirth => DateFormatter.convertToDMY(dateOfBirth);

  static Map toJson(Map json) {
    return {
      'name': json['name'],
      'email': json['email'],
      'course': json['course']['title'],
      'grade': json['grade']['title']
    };
  }

  @override
  String toString() {
    return 'UserData(email: $email, name: $name, gender: $gender, level: $level, dateOfBirth: $dateOfBirth, courseId: $courseId, gradeId: $gradeId)';
  }
}
