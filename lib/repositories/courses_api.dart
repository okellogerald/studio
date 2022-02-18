import 'dart:convert';
import '../source.dart';
import 'package:http/http.dart' as http;

class CoursesApi {
  static const root =
      'http://siila-env.eba-m2zsdqgd.ap-southeast-1.elasticbeanstalk.com/api/';

  static Future<Map<String, dynamic>> getUserCourseOverview(
      String token) async {
    const url = root + 'home';
    final header = {"Authorization": 'Bearer $token'};
    final response = await http.get(Uri.parse(url), headers: header);
    final result = json.decode(response.body);

    _handleStatusCodes(result['code']);

    // log(result.toString());
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
    final header = {"Authorization": 'Bearer $token'};
    final response = await http.get(Uri.parse(url), headers: header);
    final result = json.decode(response.body);

    _handleStatusCodes(result['code']);

    // log(result.toString());
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
    final header = {"Authorization": 'Bearer $token'};
    final response = await http.get(Uri.parse(url), headers: header);
    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);
    log(response.body.toString());
    return Lesson.fromJson(result['data']);
  }

  static Future<Map<String, dynamic>> getProfile(String token) async {
    const url = root + 'profile';
    final header = {"Authorization": 'Bearer $token'};
    final response = await http.get(Uri.parse(url), headers: header);

    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);
    //log(result.toString());
    return result['data'];
  }

  static Future<String> updateLessonStatus(
      String newStatus, String lessonId, String token) async {
    final url = root + 'lesson/$lessonId/status';
    final header = {"Authorization": 'Bearer $token'};
    final data = {'completionStatus': newStatus};
    final response =
        await http.post(Uri.parse(url), headers: header, body: data);

    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);
    log(result.toString());
    return result['data']['completionStatus'];
  }

  static Future<GeneralInfo> getGeneralInfo(String token) async {
    const url = root + 'home';
    final header = {"Authorization": 'Bearer $token'};
    final response = await http.get(Uri.parse(url), headers: header);
    final result = json.decode(response.body);

    _handleStatusCodes(result['code']);

    log(result.toString());
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
}
