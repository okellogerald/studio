import 'dart:convert';

import '../source.dart';
import 'package:http/http.dart' as http;

class OnBoardingApi {
  static const root =
      'http://siila-env.eba-m2zsdqgd.ap-southeast-1.elasticbeanstalk.com/api/';

  static Future<List<Course>> getAllCategories() async {
    const url = root + 'signup/';

    try {
      final response = await http.get(Uri.parse(url));
      final body = json.decode(response.body);

      final results = body['data']['courses'];

      final courseList = <Course>[];
      for (Map<String, dynamic> e in results) {
        courseList.add(Course.fromJson(e));
      }

      return courseList;
    } catch (_) {
      throw ApiError.unknown();
    }
  }
}
