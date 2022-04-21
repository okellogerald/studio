import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:silla_studio/manager/onboarding/providers/user_details.dart';
import 'package:silla_studio/manager/token.dart';
import 'package:silla_studio/manager/video/models/video_details.dart';
import 'package:silla_studio/secret.dart';
import '../errors/api_error.dart';
import 'homepage/models/course_overview.dart';
import 'homepage/models/general_info.dart';
import 'lesson_page/models/lesson.dart';
import 'onboarding/models/course.dart';
import 'topic_page/models/sub_topic.dart';
import 'topic_page/models/topic.dart';

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

  Future<List<Course>> getUserCourses() async {
    const url = root + 'profile/edit';
    final headers = await _getHeaders();
    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);
    log('$result');
    _handleStatusCodes(result['code']);
    final results = result['data']['courses'];
    final courses = List.from(results).map((e) => Course.fromJson(e));

    //saving user prev data
    final userCourses = result['data']['user']['userCourses'] as List;
    for (var item in userCourses) {
      ref.read(prevCourseIdsProvider.state).state.add(item['course']['id']);
    }
    return courses.toList();
  }

  Future<CourseOverview> getUserCourseOverview(
      [Map<String, dynamic>? body]) async {
    var url = body == null ? root + 'home' : root + '/profile/course';
    final headers = await _getHeaders();

    late Map<String, dynamic> result;

    if (body == null) {
      final response =
          await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
      result = json.decode(response.body);
    } else {
      final response = await http
          .put(Uri.parse(url), body: body, headers: headers)
          .timeout(timeLimit);
      log(response.body.toString());
      result = json.decode(response.body);
    }

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

  Future<List<SubTopic>> getSubTopics(String topicId) async {
    final url = root + 'topic/$topicId';
    final headers = await _getHeaders();

    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);

    final subTopics = <SubTopic>[];

    for (var topic in result['data']) {
      // log('$topic');
      subTopics.add(SubTopic(
          topic: Topic.fromJson(topic),
          lessons: List<Lesson>.from(
              topic['lessons'].map((e) => Lesson.fromJson(e)))));
    }
    return subTopics;
  }

  Future<Lesson> getLesson(String id) async {
    final url = root + 'lesson/$id';
    final headers = await _getHeaders();
    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);

    final mediaId = result['data']['mediaID'];
    if (mediaId != null) {
      final videoDetails = await _getVideoDetails(mediaId).timeout(timeLimit);
      return Lesson.fromJson(result['data'], videoDetails);
    } else {
      throw 'Video Not Found';
    }
  }

  Future<VideoDetails> _getVideoDetails(String mediaId) async {
    final url = Uri.parse('https://cdn.jwplayer.com/v2/media/$mediaId');
    final headers = {'Accept': 'application/json; charset=utf-8'};
    final response = await http.get(url, headers: headers);
    _handleStatusCodes(response.statusCode);
    final result = json.decode(response.body);
    return VideoDetails.fromJson(result['playlist'][0]);
  }

  Future<void> updateLessonStatus(String newStatus, String lessonId) async {
    final url = Uri.parse(root + 'lesson/$lessonId/status');
    final data = {'completionStatus': newStatus};
    final headers = await _getHeaders();
    final response =
        await http.post(url, headers: headers, body: data).timeout(timeLimit);
    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);
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
    final token = await ref
        .read(tokenProvider.future)
        .timeout(timeLimit)
        .catchError((error) {
      log('$error');
      throw error;
    });
    return {"Authorization": 'Bearer $token'};
  }
}
