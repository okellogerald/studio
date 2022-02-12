import '../source.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();

  const factory User(
      {required DateTime dateOfBirth,
      required String email,
      required String name,
      required String gender,
      required int courseId,
      required String level,
      required int gradeId}) = _User;

  factory User.empty() => User(
        name: '',
        email: '',
        gender: 'Male',
        level: '',
        courseId: 0,
        gradeId: 0,
        dateOfBirth: DateTime.now(),
      );

  String get getFormattedDateOfBirth => DateFormatter.convertToDMY(dateOfBirth);

  @override
  String toString() {
    return 'User(email: $email, name: $name, gender: $gender, level: $level, dateOfBirth: $dateOfBirth, courseId: $courseId, gradeId: $gradeId)';
  }
}
