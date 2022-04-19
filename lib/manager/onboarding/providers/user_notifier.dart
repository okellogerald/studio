import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:silla_studio/manager/onboarding/providers/user_repository.dart';
import '../../../constants.dart';
import '../../../errors/error_handler.dart';
import '../../courses_repository.dart';
import '../models/user.dart';
import '../models/user_state.dart';
import 'user_details.dart';

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) => UserNotifier(ref));

class UserNotifier extends StateNotifier<UserState> {
  final StateNotifierProviderRef ref;
  UserNotifier(this.ref) : super(UserState.initial());

  final _auth = FirebaseAuth.instance;
  final _box = Hive.box(kUserDataBox);

  Future<void> signUp() async {
    state = const UserState.loading('Creating your account...');

    final user = ref.read(userDetailsProvider);
    final password = ref.read(passwordProvider);
    try {
      await _auth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      final userRepository = ref.read(userRepositoryProvider);
      final result = await userRepository.createUser(user, password);
      final _userData = User.toStorageFormat(result['data']);
      await _box.put(kUserData, json.encode(_userData));
      _disposeUserDetails();
      state = const UserState.success();
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> logIn() async {
    state = const UserState.loading('Getting your credentials...');

    final user = ref.read(userDetailsProvider);
    final password = ref.read(passwordProvider);
    try {
      //to generate a token in the firebase instance
      await _auth.signInWithEmailAndPassword(
          email: user.email, password: password);
      final userRepository = ref.read(userRepositoryProvider);
      final result = await userRepository.logInUser();
      final _userData = User.toStorageFormat(result['data']);
      await _box.put(kUserData, json.encode(_userData));
      _disposeUserDetails();
      state = const UserState.success();
    } catch (error) {
      _handleError(error);
    }
  }

  Future<void> sendPasswordResetEmail() async {
    state = const UserState.loading('Sending link...');
    final user = ref.read(userDetailsProvider);
    try {
      await _auth.sendPasswordResetEmail(email: user.email).timeout(timeLimit);
      state = const UserState.success();
    } catch (error) {
      _handleError(error);
    }
  }

  Future logOut() async {
    state = const UserState.loading('Logging you out...');
    try {
      await _auth.signOut().then((value) => _box.clear());
      state = const UserState.success();
    } catch (error) {
      _handleError(error);
    }
  }

  _disposeUserDetails() {
    ref.refresh(userDetailsProvider);
    ref.refresh(passwordProvider);
    ref.refresh(passwordProvider);
  }

  _handleError(var error) {
    final message = getErrorMessage(error);
    state = UserState.failed(message);
  }
}
