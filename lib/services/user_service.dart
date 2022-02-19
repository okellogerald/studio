import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import '../source.dart';

class UserService {
  final FirebaseAuth _auth;
  UserService(this._auth);

  var _userData = {};
  Map get getUserData => _userData;

  Future<void> signUp(
      {required UserData user, required String password}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      final token = await credential.user!.getIdToken(true);
      // log('Token is $token');
      final result = await OnBoardingApi.createUser(user, password, token);
      _userData = UserData.toJson(result['data']);
    } catch (e) {
      _handleErrors(e);
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final token = await credential.user!.getIdToken(true);
      //  log('Token is $token');
      final result = await OnBoardingApi.logInUser(token);
      _userData = UserData.toJson(result['data']);
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

  Future logOutUser() async {
    await _auth.signOut().catchError((e) => _handleErrors(e));
  }

  _handleErrors(e) {
    if (e is ApiError) throw e;
    if (e is FirebaseAuthException) throw ApiError.firebaseAuth(e.message);
    if (e is SocketException) throw ApiError.internet();
    if (e is TimeoutException) throw ApiError.timeout();
    throw ApiError.unknown();
  }
}
