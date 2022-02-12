import '../source.dart';

part 'onboarding_supplements.freezed.dart';

@freezed
class OnBoardingSupplements with _$OnBoardingSupplements {
  const factory OnBoardingSupplements({
    required String password,
    required String confirmationPassword,
    required Map<String, String?> errors,
    required User user,
    required List<Course> courseList,
    required List<String> courseTypes,
  }) = _OnBoardingSupplements;

  factory OnBoardingSupplements.empty() => OnBoardingSupplements(
      password: '',
      user: User.empty(),
      errors: {},
      confirmationPassword: '',
      courseTypes: <String>[],
      courseList: <Course>[]);
}
