import '../source.dart';

part 'onboarding_supplements.freezed.dart';

@freezed
class OnBoardingSupplements with _$OnBoardingSupplements {
  const factory OnBoardingSupplements({
    required String password,
    required String confirmationPassword,
    required Map<String, String?> errors,
    required UserData user,
    required List<Course> courseList,
    required List<String> courseTypes,
    required Map<int, String> otp,
  }) = _OnBoardingSupplements;

  factory OnBoardingSupplements.empty() => OnBoardingSupplements(
      password: '',
      user: UserData.empty(),
      errors: {},
      confirmationPassword: '',
      courseTypes: <String>[],
      otp: {},
      courseList: <Course>[]);
}
