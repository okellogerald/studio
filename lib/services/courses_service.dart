import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import '../source.dart';

typedef FutureMap = Future<Map<String, dynamic>>;

class CoursesService {
  CoursesService(this._auth);

  final FirebaseAuth _auth;

  FutureMap getHomeContent() async {
   final token = 
    return await CoursesApi.getUserCourseOverview(_token)
        .catchError(handleError);
  }

  FutureMap getTopic(String id) async {
    await refreshToken();
    return await CoursesApi.getTopic(id, _token).catchError(handleError);
  }

  FutureMap getProfileData() async {
    await refreshToken();
    return await CoursesApi.getProfile(_token).catchError(handleError);
  }
}
