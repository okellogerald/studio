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
  var _lessonsIdList = <String>[];

  void init(String lessonId, List<String> lessonsIdList) async {
    var supp = state.supplements;
    emit(LessonPageState.loading(supp, message: 'fetching lesson'));

    try {
      final lesson = await service.getLesson(lessonId);
      final currentLessonIndex = lessonsIdList.indexOf(lessonId);
      final isLast = currentLessonIndex == lessonsIdList.length - 1;
      _lessonsIdList = lessonsIdList;
      supp = supp.copyWith(lesson: lesson, isLast: isLast);
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

  void goToNext() async {
    var supp = state.supplements;
    emit(LessonPageState.loading(supp, message: 'loading next lesson'));
    final currentIndex = _lessonsIdList.indexOf(supp.lesson.id);
    final nextLessonId = _lessonsIdList[currentIndex + 1];

    try {
      final lesson = await service.getLesson(nextLessonId);
      final isLast = currentIndex + 1 == _lessonsIdList.length - 1;
      supp = supp.copyWith(lesson: lesson, isLast: isLast);
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
