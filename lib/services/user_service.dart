import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import '../source.dart';

class UserService {
  final FirebaseAuth _auth;
  final _box = Hive.box(Constants.kUserDataBox);
  UserService(this._auth);

  Map get getUserData => json.decode(_box.get(Constants.kUserData));

  Future<void> signUp(
      {required UserData user, required String password}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      final token = await credential.user!.getIdToken(true);
      // log('Token is $token');
      final result = await OnBoardingApi.createUser(user, password, token);
      final _userData = UserData.toJson(result['data'], password);
      await _box.put(Constants.kUserData, json.encode(_userData));
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final token = await credential.user!.getIdToken(true);
      //  log('Token is $token');
      final result = await OnBoardingApi.logInUser(token);
      final _userData = UserData.toJson(result['data'], password);
      await _box.put(Constants.kUserData, json.encode(_userData));
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async =>
      _auth.sendPasswordResetEmail(email: email).catchError(handleError);

  Future logOutUser() async {
    await _auth.signOut().then((value) => _box.clear()).catchError(handleError);
  }
}
