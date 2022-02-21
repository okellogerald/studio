import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import '../source.dart';

typedef FutureMap = Future<Map<String, dynamic>>;

class CoursesService {
  CoursesService(this._auth);

  final FirebaseAuth _auth;
  var token = '';

  ///makes sure the token used is always valid
  Future refreshToken() async {
    final _token = await _auth.currentUser?.getIdToken();
    if (_token != null) token = _token;
  }

  Future<Map<String, dynamic>> getHomeContent() async {
    await refreshToken();
    return await CoursesApi.getUserCourseOverview(token)
        .catchError((e) => _handleError(e));
  }

  Future<Map<String, dynamic>> getTopic(String id) async {
    await refreshToken();
    return await CoursesApi.getTopic(id, token)
        .catchError((e) => _handleError(e));
  }

  Future<Map<String, dynamic>> getProfileData() async {
    await refreshToken();
    return await CoursesApi.getProfile(token)
        .catchError((e) => _handleError(e));
  }

  _handleError(e) {
    if (e is ApiError) throw e;
    if (e is FirebaseAuthException) throw ApiError.firebaseAuth(e.message);
    if (e is SocketException) throw ApiError.internet();
    if (e is TimeoutException) throw ApiError.timeout();
    log(e.toString());
    throw ApiError.unknown();
  }
}
