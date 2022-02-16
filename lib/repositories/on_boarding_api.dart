import 'dart:convert';
import '../source.dart';
import 'package:http/http.dart' as http;

class OnBoardingApi {
  static const root =
      'http://siila-env.eba-m2zsdqgd.ap-southeast-1.elasticbeanstalk.com/api/';

  static Future<List<Course>> getAllCategories() async {
    const url = root + 'signup/';

    final response = await http.get(Uri.parse(url));
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
    final headers = {
      "Authorization": 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final body = {
      'gender': userData.gender.toLowerCase(),
      'dob': userData.dateOfBirth.millisecondsSinceEpoch,
      'name': userData.name,
      'level': userData.level,
      'courseID': userData.courseId,
      'gradeID': userData.gradeId,
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));

    final result = json.decode(response.body);
    // log(result.toString());
    _handleStatusCodes(result['code']);
    return result;
  }

  static Future<Map<String, dynamic>> logInUser(String token) async {
    const url = root + 'login/';
    final headers = {
      "Authorization": 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    final response = await http.post(Uri.parse(url), headers: headers);

    final result = json.decode(response.body);
    // log(result.toString());
    _handleStatusCodes(result['code']);
    return result;
  }

  static void _handleStatusCodes(int statusCode) {
    if (statusCode != 200) throw ApiError.server();
  }
}
