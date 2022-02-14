import 'dart:convert';
import '../source.dart';
import 'package:http/http.dart' as http;

class CoursesApi {
  static const root =
      'http://siila-env.eba-m2zsdqgd.ap-southeast-1.elasticbeanstalk.com/api/';

  static Future<void> getHomeContent(String token) async {
    const url = root + 'home';
    final header = {"Authorization": 'Bearer $token'};
    final response = await http.get(Uri.parse(url), headers: header);
    final result = json.decode(response.body);

    log(result.toString());

    _handleStatusCodes(result['code']);
  }

  static void _handleStatusCodes(int statusCode) {
    if (statusCode != 200) throw ApiError.server();
  }
}
