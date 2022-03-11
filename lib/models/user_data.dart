import '../source.dart';

part 'user_data.freezed.dart';

@freezed
class UserData with _$UserData {
  const UserData._();

  const factory UserData(
      {required DateTime dateOfBirth,
      @Default('') String email,
      @Default('') String name,
      @Default('') String gender,
      @Default(0) int courseId,
      @Default('') String level,
      @Default(0) int gradeId}) = _UserData;

  factory UserData.empty() => UserData(dateOfBirth: DateTime.now());

  String get getFormattedDateOfBirth => DateFormatter.convertToDMY(dateOfBirth);

  static Map<String, dynamic> toJson(Map json) {
    return {
      'name': json['name'],
      'email': json['email'],
      'course': json['course']['title'],
      'grade': json['grade']['title']
    };
  }
}
