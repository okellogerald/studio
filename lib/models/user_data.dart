import '../source.dart';

part 'user_data.freezed.dart';

@freezed
class UserData with _$UserData {
  const UserData._();

  const factory UserData(
      {required DateTime dateOfBirth,
      @Default('') String email,
      @Default('') String name,
      String? gender,
      @Default(0) int courseId,
      @Default('') String level,
      @Default(0) int gradeId}) = _UserData;

  factory UserData.empty() => UserData(dateOfBirth: DateTime.now());

  String get getFormattedDateOfBirth => DateFormatter.convertToDMY(dateOfBirth);

  ///When user data has been saved locally, when they trying to get home content
  ///from the api requires recent login.
  static Map<String, dynamic> toJson(Map json, String password) {
    return {
      'name': json['name'],
      'email': json['email'],
      'course': json['course']['title'],
      'password': password,
      'grade': json['grade']['title']
    };
  }
}
