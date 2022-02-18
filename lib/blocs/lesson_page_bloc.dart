import '../source.dart';

class Status {
  static const completed = 'completed';
  static const incomplete = 'incomplete';
  static const pending = 'pending';
}

class LessonPageBloc extends Cubit<LessonPageState> {
  LessonPageBloc(this.service) : super(LessonPageState.initial()) {
    service.addListener(() => _handleLessonUpdates());
  }

  final LessonsService service;

  void init(String lessonId) async {
    var supp = state.supplements;
    emit(LessonPageState.loading(supp, message: 'fetching lesson'));

    try {
      final lesson = await service.getLesson(lessonId);
      supp = supp.copyWith(lesson: lesson);
      emit(LessonPageState.content(supp));
    } on ApiError catch (_) {
      emit(LessonPageState.failed(supp, _.message));
    }
  }

  void markLessonAs(String status, {required Lesson lesson}) async {
    var supp = state.supplements;
    emit(LessonPageState.loading(supp,
        message: 'marking ${lesson.title} as $status'));
    try {
      await service.updateLessonStatus(status, lesson);
    } on ApiError catch (_) {
      emit(LessonPageState.failed(supp, _.message));
    }
  }

  _handleLessonUpdates() {
    var supp = state.supplements;
    emit(LessonPageState.loading(supp));
    final newStatus = service.getUpdatedLesson.completionStatus;
    final _lesson = supp.lesson.copyWithNewStatus(newStatus);
    supp = supp.copyWith(lesson: _lesson);
    emit(LessonPageState.content(supp));
  }
}
