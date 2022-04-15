import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../manager/user/providers.dart';
import '../source.dart';

class LessonsService extends ChangeNotifier {
  LessonsService(this._auth);

  final FirebaseAuth _auth;

  var _lesson = Lesson.empty();
  Lesson get getUpdatedLesson => _lesson;

  Future<Lesson> getLesson(String id) async {
    final token = await getToken(_auth).catchError(handleError);
    return await CoursesApi.getLesson(id, token).catchError(handleError);
  }

  Future<void> updateLessonStatus(String status, Lesson lesson) async {
    final token = await getToken(_auth).catchError(handleError);
    final newStatus =
        await CoursesApi.updateLessonStatus(status, lesson.id, token)
            .catchError(handleError);
    _lesson = lesson.copyWithNewStatus(newStatus);
    notifyListeners();
  }
}
