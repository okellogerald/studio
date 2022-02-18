import '../source.dart';

class TopicPageBloc extends Cubit<TopicPageState> {
  TopicPageBloc(this.service, this.lessonsService)
      : super(TopicPageState.initial()) {
    lessonsService.addListener(() => _handleLessonUpdates());
  }

  final CoursesService service;
  final LessonsService lessonsService;

  void init(String topicId) async {
    var supp = state.supplements;
    emit(TopicPageState.loading(supp));
    try {
      final values = await service.getTopic(topicId);
      supp =
          supp.copyWith(topics: values['topics'], lessons: values['lessons']);
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
    list[index] =
        lessons[index].copyWithNewStatus(_updatedLesson.completionStatus);
    supp = supp.copyWith(lessons: list);
    emit(TopicPageState.content(supp));
  }
}
