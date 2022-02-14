import 'package:firebase_auth/firebase_auth.dart';

import '../source.dart';

class CoursesService {
  CoursesService(this._auth) {
    _auth.idTokenChanges().listen((user) => _handleIdChanges(user));
  }

  final FirebaseAuth _auth;
  var token = '';

  Future<String?> init() async {
    final _token = await _auth.currentUser?.getIdToken();
    if (_token != null) token = _token;
    return _token;
  }

  _handleIdChanges(User? user) async {
    if (user == null) {
      log('user is signed out');
    } else {
      token = await user.getIdToken();
    }
  }

  Future<void> getHomeContent() async {
    await CoursesApi.getHomeContent(token);
  }
}
