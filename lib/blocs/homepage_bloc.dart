import '../source.dart';

class HomepageBloc extends Cubit<HomepageState> {
  HomepageBloc(this.service) : super(HomepageState.initial());

  final CoursesService service;

  Future<void> init() async {
    await service.init();
    await service.getHomeContent();
  }
}
