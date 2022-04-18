import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../errors/error_handler.dart';
import '../models/course.dart';
import '../../courses_repository.dart';

final coursesProvider = FutureProvider<List<Course>>((ref) async {
  final coursesRepository = ref.read(coursesRepositoryProvider);
  final courses = await coursesRepository.getAllCourses().catchError((error) {
    final message = getErrorMessage(error);
    throw message;
  });
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
  //making dance come first
  if (types.contains('dance')) {
    types
      ..remove('dance')
      ..insert(0, 'dance');
  }
  return types;
}