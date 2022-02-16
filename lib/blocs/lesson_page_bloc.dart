import '../source.dart';

class LessonPageBloc extends Cubit<LessonPageState> {
  LessonPageBloc(this.service) : super(LessonPageState.initial());

  final CoursesService service;

  void init(String lessonId) async {
    var supp = state.supplements;
    emit(LessonPageState.loading(supp));

    try {
      final lesson = await service.getLesson(lessonId);
      supp = supp.copyWith(lesson: lesson);
      emit(LessonPageState.content(supp));
    } on ApiError catch (_) {
      emit(LessonPageState.failed(supp, _.message));
    }
  }
}
