import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../source.dart';

class LessonsService extends ChangeNotifier {
  LessonsService(this._auth);

  final FirebaseAuth _auth;
  var _token = '';

  var _lesson = Lesson.empty();
  Lesson get getUpdatedLesson => _lesson;

  Future<void> init() async {
    final token = await _auth.currentUser?.getIdToken();
    if (token != null) _token = token;
  }

  ///makes sure the _token used is valid
  Future refreshToken() async => await init();

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
