import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import '../source.dart';

class LessonsService extends ChangeNotifier {
  LessonsService(this._auth);

  final FirebaseAuth _auth;
  var _token = '';

  var _lesson = Lesson.empty();
  Lesson get getUpdatedLesson => _lesson;

  ///makes sure the token used is always valid
  Future<void> refreshToken() async {
    final token = await _auth.currentUser?.getIdToken();
    if (token != null){
      _token = token;
      return;
    }
    final user = Hive.box(Constants.kUserDataBox).get(Constants.kUserData);

    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: user['email'], password: user['password']);
      _token = await credential.user!.getIdToken();
    } catch (error) {
      handleError(error);
    }
  }

  Future<Lesson> getLesson(String id) async {
    await refreshToken();
    return await CoursesApi.getLesson(id, _token).catchError(handleError);
  }

  Future<void> updateLessonStatus(String status, Lesson lesson) async {
    await refreshToken();
    _lesson = lesson;
    final newStatus =
        await CoursesApi.updateLessonStatus(status, lesson.id, _token)
            .catchError(handleError);
    _lesson = _lesson.copyWithNewStatus(newStatus);
    notifyListeners();
  }
}
