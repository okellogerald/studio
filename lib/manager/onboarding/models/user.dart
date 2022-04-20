import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:silla_studio/utils/date_formatter.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();

  const factory User(
      {required DateTime dateOfBirth,
      @Default('') String email,
      @Default('') String name,
      @Default('Male') gender,
      @Default(0) int courseId,
      @Default('') String level,
      @Default(0) int gradeId}) = _User;

  factory User.empty() => User(dateOfBirth: DateTime.now());

  String get getFormattedDateOfBirth => DateFormatter.convertToDMY(dateOfBirth);

  static Map<String, dynamic> toStorageFormat(Map json) {
    return {
      'name': json['name'],
      'email': json['email'],
      'course': json['course']['title'],
      'grade': json['grade']['title']
    };
  }

  Map<String, dynamic> toJson() => {
        'gender': gender!.toLowerCase(),
        'dob': dateOfBirth.millisecondsSinceEpoch,
        'name': name,
        'level': level,
        'courseID': courseId,
        'gradeID': gradeId
      };
}
