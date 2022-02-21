import '../source.dart';

part 'homepage_state.freezed.dart';

@freezed
class HomepageState with _$HomepageState {
  const factory HomepageState.loading(HomepageSupplements supplements,{ String? message, @Default(false) bool isUpdatingContent}) = _Loading;
  const factory HomepageState.content(HomepageSupplements supplements) = _Content;
  const factory HomepageState.failed(HomepageSupplements supplements, String messaage) = _Failed;

  factory HomepageState.initial() => HomepageState.content(HomepageSupplements.empty());
}