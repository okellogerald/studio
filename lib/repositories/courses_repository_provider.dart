import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/token.dart';
import 'package:silla_studio/manager/video/models/video_details.dart';
import 'package:silla_studio/secret.dart';
import '../manager/courses/models/course_overview.dart';
import '../source.dart' hide Provider;
import 'package:http/http.dart' as http;

const timeLimit = Duration(seconds: 20);

final coursesRepositoryProvider = Provider((ref) => CoursesRepositoryImpl(ref));

class CoursesRepositoryImpl {
  final ProviderRef ref;
  const CoursesRepositoryImpl(this.ref);

  Future<List<Course>> getAllCourses() async {
    const url = root + 'signup/';
    final response = await http.get(Uri.parse(url)).timeout(timeLimit);
    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);
    final results = result['data']['courses'];
    final courses = List.from(results).map((e) => Course.fromJson(e));
    return courses.toList();
  }

  Future<CourseOverview> getUserCourseOverview() async {
    const url = root + 'home';
    final headers = await _getHeaders();

    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);

    final topics = List.from(result['data']).map((e) => Topic.fromJson(e));
    final currentLesson = Lesson.fromJson(result['info']['continueLesson']);
    final generalInfo = GeneralInfo(
        completedLessons: result['info']['completedLessonsCount'],
        lessonsCount: result['info']['lessonsCount']);

    return CourseOverview(
        currentLesson: currentLesson,
        generalInfo: generalInfo,
        topicList: topics.toList());
  }

  Future<Map<String, dynamic>> getTopic(String id) async {
    final url = root + 'topic/$id';
    final headers = await _getHeaders();

    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);

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

  Future<Lesson> getLesson(String id) async {
    final url = root + 'lesson/$id';
    final headers = await _getHeaders();
    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);
    final videoDetails =
        await _getVideoDetails(result['mediaID']).timeout(timeLimit);
    return Lesson.fromJson(result['data'], videoDetails);
  }

  Future<VideoDetails> _getVideoDetails(String mediaId) async {
    final url = Uri.parse('https://cdn.jwplayer.com/v2/media/$mediaId');
    final headers = {'Accept': 'application/json; charset=utf-8'};
    final response = await http.get(url, headers: headers);
    _handleStatusCodes(response.statusCode);
    final result = json.decode(response.body);
    return VideoDetails.fromJson(result['playlist'][0]);
  }

  Future<String> updateLessonStatus(String newStatus, String lessonId) async {
    final url = Uri.parse(root + 'lesson/$lessonId/status');
    final data = json.encode({'completionStatus': newStatus});
    log(data.toString());
    final headers = await _getHeaders();
    final response =
        await http.post(url, headers: headers, body: data).timeout(timeLimit);
    final result = json.decode(response.body);
    log(result.toString());
    _handleStatusCodes(result['code']);
    return result['data']['completionStatus'];
  }

  Future<GeneralInfo> getGeneralInfo() async {
    const url = root + 'home';
    final headers = await _getHeaders();
    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);

    final generalInfo = GeneralInfo(
        completedLessons: result['info']['completedLessonsCount'],
        lessonsCount: result['info']['lessonsCount']);
    return generalInfo;
  }

  void _handleStatusCodes(int statusCode) {
    if (statusCode == 200) return;
    if (statusCode == 701) throw ApiError.expiredToken();
    throw ApiError.unknown();
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = ref
        .read(tokenProvider.future)
        .timeout(timeLimit)
        .catchError((error) => throw error);
    return {"Authorization": 'Bearer $token'};
  }
}
