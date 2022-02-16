import '../source.dart';

class TopicPageBloc extends Cubit<TopicPageState> {
  TopicPageBloc(this.service) : super(TopicPageState.initial());

  final CoursesService service;

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
    log(supp.lessons.toString());
    switch (filterTypeIndex) {
      case 0:
        break;
      default:
    }
    supp = supp.copyWith(filterType: filterTypes[filterTypeIndex]);
    emit(TopicPageState.content(supp));
  }
}
