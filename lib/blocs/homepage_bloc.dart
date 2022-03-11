import '../source.dart';

class HomepageBloc extends Cubit<HomepageState> {
  HomepageBloc(this.coursesService, this.userService, this.lessonsService)
      : super(HomepageState.initial()) {
    lessonsService.addListener(() => _handleLessonUpdates());
  }

  final CoursesService coursesService;
  final UserService userService;
  final LessonsService lessonsService;

  Future<void> init([bool isUpdatingContent = false]) async {
    var supp = state.supplements;
    emit(HomepageState.loading(supp, isUpdatingContent: isUpdatingContent));

    try {
      final values = await coursesService.getHomeContent();
      log(values.toString());
      final userData = userService.getUserData;
      log('userdata');
      log(userData.toString());
      supp = supp.copyWith(
          lesson: values['lessons'],
          topicList: values['topics'],
          userData: userData,
          generalInfo: values['generalInfo']);

      emit(HomepageState.content(supp));
    } on ApiError catch (_) {
      final error = isUpdatingContent ? 'Failed to update content' : _.message;
      emit(HomepageState.failed(supp, error, showOnScreen: isUpdatingContent));
    }
  }

  _handleLessonUpdates() async => await init(true);

  Future<void> refresh() async => await init(true);
}
