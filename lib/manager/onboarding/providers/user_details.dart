import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../../constants.dart';
import '../models/user.dart';

final _box = Hive.box(kUserDataBox);

final userDetailsProvider = StateProvider<User>((ref) => User.empty());

final passwordProvider = StateProvider<String>((ref) => '');

final confirmationPasswordProvider = StateProvider<String>((ref) => '');

final signedInUserDataProvider = Provider<Map<String, dynamic>>((ref) {
  final jsonUser = _box.get(kUserData) as String?;
  if (jsonUser == null) throw 'User-data is not supposed to be null';
  return json.decode(jsonUser);
});

///stores user details in the user details provider
void updateUserDetails(WidgetRef ref,
    {String? email,
    String? password,
    String? confirmationPassword,
    String? name,
    int? courseId,
    int? gradeId,
    String? level,
    String? gender,
    DateTime? dateOfBirth}) {
  final user = ref.read(userDetailsProvider);
  final _password = ref.read(passwordProvider);
  final _confirmationPassword = ref.read(confirmationPasswordProvider);

  final updatedUser = user.copyWith(
      email: email ?? user.email,
      name: name ?? user.name,
      gender: gender ?? user.gender,
      dateOfBirth: dateOfBirth ?? user.dateOfBirth,
      level: level ?? user.level,
      courseId: courseId ?? user.courseId,
      gradeId: gradeId ?? user.gradeId);
  ref.read(passwordProvider.state).state = password ?? _password;
  ref.read(confirmationPasswordProvider.state).state =
      confirmationPassword ?? _confirmationPassword;
  ref.read(userDetailsProvider.state).state = updatedUser;
}
