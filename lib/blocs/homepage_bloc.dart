import '../source.dart';

class HomepageBloc extends Cubit<HomepageState> {
  HomepageBloc(this.coursesService, this.userService, this.lessonsService)
      : super(HomepageState.initial()) {
    lessonsService.addListener(() => _handleLessonUpdates());
  }

  final CoursesService coursesService;
  final UserService userService;
  final LessonsService lessonsService;

  Future<void> init() async {
    var supp = state.supplements;
    emit(HomepageState.loading(supp));

    try {
      await coursesService.init();
      final values = await coursesService.getHomeContent();
      final userData = userService.getUserData;
      supp = supp.copyWith(
          lesson: values['lessons'],
          topicList: values['topics'],
          userData: userData,
          generalInfo: values['generalInfo']);
      emit(HomepageState.content(supp));
    } on ApiError catch (_) {
      emit(HomepageState.failed(supp, _.message));
    }
  }

  _handleLessonUpdates() async {
    var supp = state.supplements;
    emit(HomepageState.loading(supp));

    final _updatedLesson = lessonsService.getUpdatedLesson;
    if (_updatedLesson.id == supp.lesson.id) {
      final _lesson =
          supp.lesson.copyWithNewStatus(_updatedLesson.completionStatus);
      supp = supp.copyWith(lesson: _lesson);
    }
    log('updating the general info');
    final generalInfo = await coursesService.getRefreshedGeneralInfo();
    supp = supp.copyWith(generalInfo: generalInfo);
    emit(HomepageState.content(supp));
  }
}
