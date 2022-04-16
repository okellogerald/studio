import 'package:silla_studio/errors/app_error.dart';

import '../source.dart';

class ProfilePageBloc extends Cubit<ProfilePageState> {
  ProfilePageBloc(this.coursesService, this.userService)
      : super(ProfilePageState.initial());

  final CoursesService coursesService;
  final UserService userService;

  void init() async {
    var userData = state.userData;
    emit(ProfilePageState.loading(userData, message: 'Loading profile'));

    try {
      userData = await coursesService.getProfileData();
      emit(ProfilePageState.content(userData));
    } on ApiError catch (e) {
      emit(ProfilePageState.failed(userData, AppError.onBody(e.message)));
    }
  }

  void logOut() async {
    var userData = state.userData;
    emit(ProfilePageState.loading(userData));

    try {
      await userService.logOutUser();
      emit(ProfilePageState.success(userData));
    } on ApiError catch (e) {
      emit(ProfilePageState.failed(userData, AppError(e.message)));
    }
  }
}
