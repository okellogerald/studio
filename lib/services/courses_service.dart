import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import '../source.dart';

class CoursesService {
  CoursesService(this._auth) {
    _auth.idTokenChanges().listen((user) => _handleIdChanges(user));
  }

  final FirebaseAuth _auth;
  var token = '';

  Future<String?> init() async {
    final _token = await _auth.currentUser?.getIdToken();
    if (_token != null) token = _token;
    return _token;
  }

  Future<Map<String, dynamic>> getHomeContent() async {
    return await CoursesApi.getUserCourseOverview(token)
        .catchError((e) => _handleError(e));
  }

  Future<Map<String, dynamic>> getTopic(String id) async {
    return await CoursesApi.getTopic(id, token)
        .catchError((e) => _handleError(e));
  }

  _handleIdChanges(User? user) async {
    if (user == null) {
      log('user is signed out');
    } else {
      log('assigning another token');
      token = await user.getIdToken();
      log('done assigning');
    }
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
