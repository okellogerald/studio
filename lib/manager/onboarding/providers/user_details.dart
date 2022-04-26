import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

final userDetailsProvider = StateProvider<User>((ref) => User.empty());

final passwordProvider = StateProvider<String>((ref) => '');

final confirmationPasswordProvider = StateProvider<String>((ref) => '');

final signedInUserDataProvider =
    StateProvider<Map<String, dynamic>?>((ref) => null);

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

///when the user is changing the course
///
///All course-ids that the user has ever learnt are stored in here, so that
///when the user changes grade, we don't have to ask about the level again she
///is at.
final prevCourseIdsProvider = StateProvider<List<int>>((ref) => []);
