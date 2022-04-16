import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:silla_studio/manager/token.dart';
import 'package:silla_studio/secret.dart';

import '../../source.dart' hide Provider;
import 'models/user.dart';

final userRepositoryProvider = Provider((ref) => UserRepositoryImpl(ref));

class UserRepositoryImpl {
  final ProviderRef ref;
  const UserRepositoryImpl(this.ref);

  Future<Map<String, dynamic>> createUser(User user, String password) async {
    const url = root + 'signup/';
    final body = user.toJson();
    final headers = await _getHeaders();
    final response = await http
        .post(Uri.parse(url), headers: headers, body: json.encode(body))
        .timeout(timeLimit);
    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);
    return result;
  }

  Future<Map<String, dynamic>> logInUser() async {
    const url = root + 'login/';
    final headers = await _getHeaders();
    final response =
        await http.post(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);
    return result;
  }

  Future<Map<String, dynamic>> getProfile() async {
    const url = root + 'profile';
    final headers = await _getHeaders();
    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    final result = json.decode(response.body);
    _handleStatusCodes(result['code']);
    return result['data'];
  }

  Future<List<Course>> getAllCourses() async {
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

  void _handleStatusCodes(int statusCode) {
    if (statusCode == 200) return;
    if (statusCode == 701) throw ApiError.expiredToken();
    throw ApiError.unknown();
  }

  Future<Map<String, String>> _getHeaders() async {
    final _headers = Map<String, String>.from(headers);
    final token = await ref
        .read(tokenProvider.future)
        .timeout(timeLimit)
        .catchError((e) => throw (e));
    _headers["Authorization"] = 'Bearer $token';
    return _headers;
  }
}
