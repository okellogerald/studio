import '../source.dart';

part 'homepage_state.freezed.dart';

@freezed
class HomepageState with _$HomepageState {
  const factory HomepageState.loading(HomepageSupplements supplements) = _Loading;
  const factory HomepageState.content(HomepageSupplements supplements) = _Content;

  factory HomepageState.initial() => HomepageState.content(HomepageSupplements.empty());
}