import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../manager/user_action.dart';
import '../source.dart';

String getErrorMessage(var error) {
  if (error is String) return error;
  if (error is ApiError) return error.message;
  if (error is FirebaseAuthException) error.message;
  if (error is SocketException) return ApiError.internet().message;
  if (error is TimeoutException) return ApiError.timeout().message;
  log(error.toString());
  return ApiError.unknown().message;
}

String getUserActionFailureTitle(WidgetRef ref) {
  final userAction = ref.read(userActionProvider);

  switch (userAction) {
    case UserAction.viewLesson:
      return 'We failed to get the lesson data';
    case UserAction.viewCourses:
      return 'Could not fetch the courses';
    case UserAction.viewProfile:
      return 'Could not load your profile';
    case UserAction.viewTopic:
      return 'Failed to get the topic lessons data';
    case UserAction.viewHomepage:
      return 'We failed to get your content.';
    default:
  }
  return "";
}
