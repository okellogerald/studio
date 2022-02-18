import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import '../source.dart';

typedef FutureMap = Future<Map<String, dynamic>>;

class CoursesService {
  CoursesService(this._auth) {
    _auth.idTokenChanges().listen((user) => _handleIdChanges(user));
  }

  final FirebaseAuth _auth;
  var token = '';

  Future<String?> init() async {
    log('changed the token');
    final _token = await _auth.currentUser?.getIdToken();
    if (_token != null) token = _token;
    return _token;
  }

  FutureMap getHomeContent() async {
    return await CoursesApi.getUserCourseOverview(token)
        .catchError((e) => _handleError(e));
  }

  FutureMap getTopic(String id) async {
    return await CoursesApi.getTopic(id, token)
        .catchError((e) => _handleError(e));
  }

  Future<Lesson> getLesson(String id) async {
    FutureMap callback() async {
      final result = await CoursesApi.getLesson(id, token);
      return result['lesson'];
    }

    return await _handleCallbacks(callback);
  }

  FutureMap getProfileData() async {
    FutureMap callback() async {
      return await CoursesApi.getProfile(token);
    }

    return await _handleCallbacks(callback);
  }

  ///handles the errors that may happen when calling an aoi.
  Future _handleCallbacks(Function callback) async {
    var result = <String, dynamic>{};

    try {
      result = await callback();
    } on ApiError catch (e) {
      if (e.message == 'Token') {
        await init();
        result = await callback();
      } else {
        _handleError(e);
      }
    } catch (e) {
      _handleError(e);
    }

    return result;
  }

  _handleIdChanges(User? user) async {
    if (user == null) {
      log('user is signed out');
    } else {
      token = await user.getIdToken();
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
