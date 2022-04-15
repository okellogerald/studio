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

  void init(String lessonId, List<String> lessonsIdList) async {
    var supp = state.supplements;
    emit(LessonPageState.loading(supp, message: 'fetching lesson'));

    try {
      final lesson = await service.getLesson(lessonId);
      final currentLessonIndex = lessonsIdList.indexOf(lessonId);
      supp = supp.copyWith(
          lesson: lesson,
          lessonsIdList: lessonsIdList,
          currentIndex: currentLessonIndex,
          lessonsLength: lessonsIdList.length);
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
      log('updating status');
      log(status);
      await service.updateLessonStatus(status, lesson);
      log('done');
    } on ApiError catch (_) {
      emit(LessonPageState.failed(supp, _.message));
    }
  }

  void goToNext() async {
    var supp = state.supplements;
    emit(LessonPageState.loading(supp, message: 'loading next lesson'));
    final lessonsIdList = supp.lessonsIdList;
    final currentIndex = lessonsIdList.indexOf(supp.lesson.id);
    final nextLessonId = lessonsIdList[currentIndex + 1];

    try {
      final lesson = await service.getLesson(nextLessonId);
      supp = supp.copyWith(lesson: lesson, currentIndex: currentIndex + 1);
      emit(LessonPageState.content(supp));
    } on ApiError catch (_) {
      emit(LessonPageState.failed(supp, _.message));
    }
  }

  void goToPrev() async {
    var supp = state.supplements;
    emit(LessonPageState.loading(supp, message: 'loading previous lesson'));
    final lessonsIdList = supp.lessonsIdList;
    final currentIndex = lessonsIdList.indexOf(supp.lesson.id);
    final nextLessonId = lessonsIdList[currentIndex - 1];

    try {
      final lesson = await service.getLesson(nextLessonId);
      supp = supp.copyWith(lesson: lesson, currentIndex: currentIndex - 1);
      emit(LessonPageState.content(supp));
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
