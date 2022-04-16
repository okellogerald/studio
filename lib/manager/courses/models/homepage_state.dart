import 'package:freezed_annotation/freezed_annotation.dart';
import 'course_overview.dart';

part 'homepage_state.freezed.dart';

@freezed
class HomepageState with _$HomepageState {
  const factory HomepageState.loading([String? message]) = _Loading;
  const factory HomepageState.content(CourseOverview courseOverview,
      [@Default(false) bool isUpdating]) = _Content;
  const factory HomepageState.failed(String message) = _Failed;

  factory HomepageState.initial() =>
      HomepageState.content(CourseOverview.empty());
}
