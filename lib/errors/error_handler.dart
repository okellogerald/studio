import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import '../source.dart';

handleError(e) {
  if (e is ApiError) throw e;
  if (e is FirebaseAuthException) throw ApiError.firebaseAuth(e.message);
  if (e is SocketException) throw ApiError.internet();
  if (e is TimeoutException) throw ApiError.timeout();
  log(e.toString());
  throw ApiError.unknown();
}
