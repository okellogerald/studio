import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:silla_studio/manager/user/providers.dart';
import '../source.dart';

typedef FutureMap = Future<Map<String, dynamic>>;

class CoursesService {
  CoursesService(this._auth);

  final FirebaseAuth _auth;

  FutureMap getHomeContent() async {
    final token = await getToken(_auth).catchError(handleError);
    return await CoursesApi.getUserCourseOverview(token)
        .catchError(handleError);
  }

  FutureMap getTopic(String id) async {
    final token = await getToken(_auth).catchError(handleError);
    return await CoursesApi.getTopic(id, token).catchError(handleError);
  }

  FutureMap getProfileData() async {
    final token = await getToken(_auth).catchError(handleError);
    return await CoursesApi.getProfile(token).catchError(handleError);
  }
}
