import '../source.dart';

part 'onboarding_supplements.freezed.dart';

@freezed
class OnBoardingSupplements with _$OnBoardingSupplements {
  const factory OnBoardingSupplements({
    @Default('') String password,
    @Default('') String confirmationPassword,
    @Default({}) Map<String, String?> errors,
    required UserData user,
    @Default([]) List<Course> courseList,
    @Default([]) List<String> courseTypes,
  }) = _OnBoardingSupplements;

  factory OnBoardingSupplements.empty() =>
      OnBoardingSupplements(user: UserData.empty());
}
