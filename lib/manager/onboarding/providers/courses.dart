import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/onboarding/providers/user_details.dart';
import '../../../errors/error_handler.dart';
import '../models/course.dart';
import '../../courses_repository.dart';

final coursesProvider = FutureProvider<List<Course>>((ref) async {
  final coursesRepository = ref.read(coursesRepositoryProvider);
  late List<Course> courses;
  final user = ref.read(signedInUserDataProvider);
  if (user != null) {
    log('in here');
    courses = await coursesRepository.getUserCourses().catchError((error) {
      final message = getErrorMessage(error);
      throw message;
    });
  } else {
    courses = await coursesRepository.getAllCourses().catchError((error) {
      final message = getErrorMessage(error);
      throw message;
    });
  }

  courses.sort((a, b) => a.id.compareTo(b.id));
  final courseTypes = _getCourseTypes(courses);
  ref.read(coursesTypesProvider.state).state = courseTypes;
  return courses;
});

final coursesTypesProvider = StateProvider<List<String>>((ref) => []);

List<String> _getCourseTypes(List<Course> courses) {
  final types = <String>[];
  for (Course course in courses) {
    if (!types.contains(course.type)) types.add(course.type);
  }
  return types;
}
