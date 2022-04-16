import '../errors/app_error.dart';
import '../manager/user/user_actions.dart';
import '../source.dart';

part 'onboarding_pages_state.freezed.dart';

@freezed
class OnBoardingPagesState with _$OnBoardingPagesState {
  const factory OnBoardingPagesState.laoding(Pages page, OnBoardingSupplements supplements, {String? message}) = _Loading;
  const factory OnBoardingPagesState.content (Pages page,OnBoardingSupplements supplements) = _Content;
  const factory OnBoardingPagesState.success(Pages page, OnBoardingSupplements supplements) = _Success;
  const factory OnBoardingPagesState.failed(Pages page, OnBoardingSupplements supplements, AppError error) = _Failed;

  factory OnBoardingPagesState.initial() => OnBoardingPagesState.content(Pages.logInPage,OnBoardingSupplements.empty());
}
