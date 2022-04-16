import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:silla_studio/repositories/source.dart';
import '../../models/course.dart';

final coursesProvider = StateProvider<List<Course>>((ref) => []);

final coursesTypesProvider = Provider<List<String>>((ref) {
  final courses = ref.read(coursesProvider);
  final types = <String>[];
  for (Course course in courses) {
    if (!types.contains(course.type)) types.add(course.type);
  }
  return types;
});
