import 'package:firebase_auth/firebase_auth.dart';

import '../source.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  Future signUp({required String email, required String password}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //credential.user.uid;
    } catch (e) {
      throw ApiError.unknown();
    }
  }

  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw ApiError.unknown();
    }
  }

  Future signOut() async => await _auth.signOut();
}
