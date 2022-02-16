import '../source.dart';

class HomepageBloc extends Cubit<HomepageState> {
  HomepageBloc(this.coursesService, this.userService)
      : super(HomepageState.initial());

  final CoursesService coursesService;
  final UserService userService;

  Future<void> init() async {
    var supp = state.supplements;
    emit(HomepageState.loading(supp));
    await coursesService.init();
    final values = await coursesService.getHomeContent();
    final userData = userService.getUserData;
    supp = supp.copyWith(
        lesson: values['lessons'],
        topicList: values['topics'],
        userData: userData,
        generalInfo: values['generalInfo']);
    emit(HomepageState.content(supp));
  }
}
