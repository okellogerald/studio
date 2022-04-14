import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:silla_studio/constants.dart';

final tokenProvider =
    FutureProvider.family<String, FirebaseAuth>((ref, auth) async {
  final token = await auth.currentUser?.getIdToken();
  if (token != null) return token;
  final user = Hive.box(Constants.kUserDataBox).get(Constants.kUserData);
  final credential = await auth.signInWithEmailAndPassword(
      email: user['email'], password: user['password']);
  return await credential.user!.getIdToken();
});

