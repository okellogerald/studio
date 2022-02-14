import '../source.dart';

part 'homepage_supplements.freezed.dart';

@freezed
class HomepageSupplements with _$HomepageSupplements {
  const factory HomepageSupplements() = _HomepageSupplements;

  factory HomepageSupplements.empty() => const HomepageSupplements();
}
