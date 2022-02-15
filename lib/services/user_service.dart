import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import '../source.dart';

class UserService {
  final _box = Hive.box(Constants.userDataBox);
  final FirebaseAuth _auth;
  UserService(this._auth);

  Map get getUserData => json.decode(_box.get('user_data'));

  Future<void> signUp(
      {required UserData user, required String password}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      final token = await credential.user!.getIdToken(true);
      log('Token is $token');
      final result = await OnBoardingApi.createUser(user, password, token);
      final userData = UserData.toJson(result['data']);
      await _box.put('user_data', json.encode(userData));
    } catch (e) {
      _handleErrors(e);
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final token = await credential.user!.getIdToken(true);
      log('Token is $token');
      final result = await OnBoardingApi.logInUser(token);
      final userData = UserData.toJson(result['data']);
      await _box.put('user_data', json.encode(userData));
    } catch (e) {
      _handleErrors(e);
    }
  }

  Future<void> sendEmailForVerification(String email) async => _auth
      .sendPasswordResetEmail(email: email)
      .catchError((e) => _handleErrors(e));

  Map<int, String> updateOTP(Map<int, String> current, int id, int otp) {
    current[id] = otp.toString();
    return current;
  }

  Future signOut() async {
    await _auth.signOut().catchError((e) => _handleErrors(e));
  }

  _handleErrors(e) {
    if (e is ApiError) throw e;
    if (e is FirebaseAuthException) throw ApiError.firebaseAuth(e.message);
    if (e is SocketException) throw ApiError.internet();
    if (e is TimeoutException) throw ApiError.timeout();
    log(e.toString());
    throw ApiError.unknown();
  }
}
