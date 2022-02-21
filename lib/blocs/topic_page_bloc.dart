import '../source.dart';

class TopicPageBloc extends Cubit<TopicPageState> {
  TopicPageBloc(this.service, this.lessonsService)
      : super(TopicPageState.initial()) {
    lessonsService.addListener(() => _handleLessonUpdates());
  }

  final CoursesService service;
  final LessonsService lessonsService;

  void init(Topic topic) async {
    var supp = state.supplements;
    emit(TopicPageState.loading(supp));
    try {
      final values = await service.getTopic(topic.id);
      supp = supp.copyWith(
          topics: values['topics'],
          lessons: values['lessons'],
          completedCount: topic.completedLessons);
      emit(TopicPageState.content(supp));
    } on ApiError catch (_) {
      emit(TopicPageState.failed(supp, _.message));
    }
  }

  void updateFilterType(int filterTypeIndex) {
    final filterTypes = [
      FilterType.all,
      FilterType.learn,
      FilterType.practice,
      FilterType.free,
      FilterType.paid
    ];
    var supp = state.supplements;
    emit(TopicPageState.loading(supp));
    supp = supp.copyWith(filterType: filterTypes[filterTypeIndex]);
    emit(TopicPageState.content(supp));
  }

  _handleLessonUpdates() {
    var supp = state.supplements;
    final _updatedLesson = lessonsService.getUpdatedLesson;
    final index = supp.lessons.indexWhere((e) => e.id == _updatedLesson.id);

    if (index == -1) return;

    emit(TopicPageState.loading(supp));
    final lessons = supp.lessons;
    //converting to unmodifiable list to a modifiable one
    final list = List<Lesson>.from(lessons);
    final completionStatus = _updatedLesson.completionStatus;
    var completedCount = supp.completedCount;
    list[index] = lessons[index].copyWithNewStatus(completionStatus);
    if (completionStatus == Status.completed) completedCount += 1;
    if (completionStatus == Status.incomplete) completedCount -= 1;

    supp = supp.copyWith(lessons: list, completedCount: completedCount);
    emit(TopicPageState.content(supp));
  }
}
