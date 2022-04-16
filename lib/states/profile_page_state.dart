import '../errors/app_error.dart';
import '../source.dart';


part 'profile_page_state.freezed.dart';

@freezed
class ProfilePageState with _$ProfilePageState {
  const factory ProfilePageState.loading(Map<String,dynamic> userData, {String? message}) = _Loading;
  const factory ProfilePageState.content(Map<String,dynamic> userData) = _Content;
  const factory ProfilePageState.failed(Map<String,dynamic> userData,  AppError error) = _Failed;
  const factory ProfilePageState.success(Map<String,dynamic> userData) = _Success;


  factory ProfilePageState.initial() => const ProfilePageState.content({});
}