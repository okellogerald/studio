import 'package:silla_studio/secret.dart';

import '../source.dart';
import 'package:http/http.dart' as http;

const timeLimit = Duration(seconds: 20);

class CoursesApi {
  static Future<Map<String, dynamic>> getUserCourseOverview(
      String token) async {
    const url = root + 'home';
    final headers = _getHeaders(token);
    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    log(response.body.toString());

    final result = json.decode(response.body);

    log(result.toString());

    _handleStatusCodes(result['code']);

    final topicList = <Topic>[];
    final values = <String, dynamic>{};

    for (var item in result['data']) {
      topicList.add(Topic.fromJson(item));
    }

    final continueLesson = Lesson.fromJson(result['info']['continueLesson']);
    final generalInfo = GeneralInfo(
        completedLessons: result['info']['completedLessonsCount'],
        lessonsCount: result['info']['lessonsCount']);

    values['lessons'] = continueLesson;
    values['topics'] = topicList;
    values['generalInfo'] = generalInfo;

    return values;
  }

  static Future<Map<String, dynamic>> getTopic(String id, String token) async {
    final url = root + 'topic/$id';
    final headers = _getHeaders(token);
    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);

    _handleStatusCodes(result['code']);

    //log(result.toString());
    final values = <String, List>{};
    final topicList = <Topic>[];
    final lessonList = <Lesson>[];

    for (var topic in result['data']) {
      topicList.add(Topic.fromJson(topic));
      for (var lesson in topic['lessons']) {
        lessonList.add(Lesson.fromJson(lesson));
      }
    }

    values['topics'] = topicList;
    values['lessons'] = lessonList;

    return values;
  }

  static Future<Lesson> getLesson(String id, String token) async {
    final url = root + 'lesson/$id';
    final headers = _getHeaders(token);
    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);

    _handleStatusCodes(result['code']);

    //log(response.body.toString());
    return Lesson.fromJson(result['data']);
  }

  static Future<Map<String, dynamic>> getProfile(String token) async {
    const url = root + 'profile';
    final headers = _getHeaders(token);
    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);

    _handleStatusCodes(result['code']);

    //log(result.toString());
    return result['data'];
  }

  static Future<String> updateLessonStatus(
      String newStatus, String lessonId, String token) async {
    final url = root + 'lesson/$lessonId/status';
    final data = json.encode({'completionStatus': newStatus});
    final headers = _getHeaders(token);
    final response = await http
        .post(Uri.parse(url), headers: headers, body: data)
        .timeout(timeLimit);
    final result = json.decode(response.body);

    _handleStatusCodes(result['code']);

    //log(result.toString());
    return result['data']['completionStatus'];
  }

  static Future<GeneralInfo> getGeneralInfo(String token) async {
    const url = root + 'home';
    final headers = _getHeaders(token);
    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);

    _handleStatusCodes(result['code']);

    //log(result.toString());

    final generalInfo = GeneralInfo(
        completedLessons: result['info']['completedLessonsCount'],
        lessonsCount: result['info']['lessonsCount']);
    return generalInfo;
  }

  static void _handleStatusCodes(int statusCode) {
    if (statusCode == 200) return;
    if (statusCode == 701) throw ApiError.expiredToken();
    throw ApiError.unknown();
  }

  static Map<String, String> _getHeaders(String token) {
    return {"Authorization": 'Bearer $token'};
  }
}
