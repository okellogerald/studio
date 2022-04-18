import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:silla_studio/manager/token.dart';
import 'package:silla_studio/secret.dart';
import '../../../errors/api_error.dart';
import '../../courses_repository.dart';
import '../models/user.dart';

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
    _handleStatusCodes(response.statusCode);
    final result = json.decode(response.body);
    return result;
  }

  Future<Map<String, dynamic>> logInUser() async {
    const url = root + 'login/';
    final headers = await _getHeaders();
    final response =
        await http.post(Uri.parse(url), headers: headers).timeout(timeLimit);
    _handleStatusCodes(response.statusCode);
    final result = json.decode(response.body);
    return result;
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    const url = root + 'profile';
    final headers = await _getHeaders();
    final response =
        await http.get(Uri.parse(url), headers: headers).timeout(timeLimit);
    _handleStatusCodes(response.statusCode);
    final result = json.decode(response.body);
    return result['data'];
  }

  void _handleStatusCodes(int statusCode) {
    if (statusCode == 200) return;
    if (statusCode == 701) throw ApiError.expiredToken();
    throw ApiError.unknown();
  }

  Future<Map<String, String>> _getHeaders() async {
    final _headers = Map<String, String>.from({'Content-Type': 'application/json'});
    final token = await ref
        .read(tokenProvider.future)
        .timeout(timeLimit)
        .catchError((e) => throw (e));
    _headers["Authorization"] = 'Bearer $token';
    return _headers;
  }
}
