import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/manager/courses/models/course_overview.dart';
import 'package:silla_studio/repositories/source.dart';

import '../../errors/error_handler.dart';

final getUserCourseOverview = FutureProvider<CourseOverview>((ref) async {
  final courseRepository = ref.read(coursesRepositoryProvider);
  try {
    return await courseRepository.getUserCourseOverview();
  } catch (error) {
    throw getErrorMessage(error);
  }
});

