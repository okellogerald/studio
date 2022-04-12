import 'dart:async';
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

  FutureMap getHomeContent() async {
    await refreshToken();
    return await CoursesApi.getUserCourseOverview(token)
        .catchError(handleError);
  }

  FutureMap getTopic(String id) async {
    await refreshToken();
    return await CoursesApi.getTopic(id, token).catchError(handleError);
  }

  FutureMap getProfileData() async {
    await refreshToken();
    return await CoursesApi.getProfile(token).catchError(handleError);
  }
}
