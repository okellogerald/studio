import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:silla_studio/manager/onboarding/courses_provider.dart';
import '../../source.dart' hide Provider;
import 'models/user.dart';
import 'models/user_state.dart';
import 'user_details_providers.dart';

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) => UserNotifier(ref));

class UserNotifier extends StateNotifier<UserState> {
  final StateNotifierProviderRef ref;
  UserNotifier(this.ref) : super(UserState.initial());

  final _auth = FirebaseAuth.instance;
  final _box = Hive.box(kUserDataBox);

  Future<void> signUp() async {
    state = const UserState.loading();

    final user = ref.read(userDetailsProvider);
    final password = ref.read(passwordProvider);
    try {
      await _auth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      final userRepository = ref.read(userRepositoryProvider);
      final result = await userRepository.createUser(user, password);
      final _userData = User.toStorageFormat(result['data']);
      await _box.put(kUserData, json.encode(_userData));
      state = const UserState.success();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> logIn() async {
    state = const UserState.loading();

    final user = ref.read(userDetailsProvider);
    final password = ref.read(passwordProvider);
    try {
      //to generate a token in firebase instance
      await _auth.signInWithEmailAndPassword(
          email: user.email, password: password);
      final userRepository = ref.read(userRepositoryProvider);
      final result = await userRepository.logInUser();
      final _userData = User.toStorageFormat(result['data']);
      await _box.put(kUserData, json.encode(_userData));
      state = const UserState.success();
    } catch (error) {
      _handleError(error);
    }
  }

  Future<void> getCourses() async {
    state = const UserState.loading();
    try {
      final userRepository = ref.read(userRepositoryProvider);
      final courses = await userRepository.getAllCourses();
      ref.read(coursesProvider.state).state = courses;
      state = const UserState.success();
    } catch (error) {
      _handleError(error);
    }
  }

  Future<void> sendPasswordResetEmail() async {
    state = const UserState.loading();
    final user = ref.read(userDetailsProvider);
    await _auth
        .sendPasswordResetEmail(email: user.email)
        .timeout(timeLimit)
        .catchError(_handleError);
    state = const UserState.success();
  }

  Future logOutUser() async {
    state = const UserState.loading();
    try {
      await _auth.signOut().then((value) => _box.clear());
      state = const UserState.success();
    } catch (error) {
      _handleError(error);
    }
  }

  _handleError(var error) {
    final message = getErrorMessage(error);
    state = UserState.failed(message);
  }
}
