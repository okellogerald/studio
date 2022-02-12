import '../source.dart';

part 'onboarding_pages_state.freezed.dart';

@freezed
class OnBoardingPagesState with _$OnBoardingPagesState {
  const factory OnBoardingPagesState.laoding(OnBoardingSupplements supplements, {String? message}) = _Loading;
  const factory OnBoardingPagesState.content(OnBoardingSupplements supplements) = _Content;
  const factory OnBoardingPagesState.success(OnBoardingSupplements supplements) = _Success;
  const factory OnBoardingPagesState.failed(OnBoardingSupplements supplements, String message) = _Failed;

  factory OnBoardingPagesState.initial() => OnBoardingPagesState.content(OnBoardingSupplements.empty());
}
