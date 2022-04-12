import 'package:silla_studio/secret.dart';

import '../source.dart';
import 'package:http/http.dart' as http;

class OnBoardingApi {
  static Future<List<Course>> getAllCategories() async {
    const url = root + 'signup/';
    final response = await http.get(Uri.parse(url)).timeout(timeLimit);
    final result = json.decode(response.body);

    _handleStatusCodes(result['code']);

    final results = result['data']['courses'];
    final courseList = <Course>[];
    for (Map<String, dynamic> e in results) {
      courseList.add(Course.fromJson(e));
    }

    return courseList;
  }

  static Future<Map<String, dynamic>> createUser(
      UserData userData, String password, String token) async {
    const url = root + 'signup/';
    final body = {
      'gender': userData.gender!.toLowerCase(),
      'dob': userData.dateOfBirth.millisecondsSinceEpoch,
      'name': userData.name,
      'level': userData.level,
      'courseID': userData.courseId,
      'gradeID': userData.gradeId,
    };

    final headers = _getHeaders(token);
    final response = await http
        .post(Uri.parse(url), headers: headers, body: json.encode(body))
        .timeout(timeLimit);
    final result = json.decode(response.body);
    // log(result.toString());
    _handleStatusCodes(result['code']);
    return result;
  }

  static Future<Map<String, dynamic>> logInUser(String token) async {
    const url = root + 'login/';
    final headers = _getHeaders(token);
    final response =
        await http.post(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);
     log(result.toString());
    _handleStatusCodes(result['code']);
    return result;
  }

  static void _handleStatusCodes(int statusCode) {
    if (statusCode == 200) return;
    if (statusCode == 701) throw ApiError.expiredToken();
    throw ApiError.unknown();
  }

  static Map<String, String> _getHeaders(String token) {
    final _headers = Map<String, String>.from(headers);
    _headers["Authorization"] = 'Bearer $token';
    return _headers;
  }
}
