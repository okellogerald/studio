import '../source.dart';

class TopicPageBloc extends Cubit<TopicPageState> {
  TopicPageBloc(this.service) : super(TopicPageState.initial());

  final CoursesService service;

  void init(String topicId) async {
    var supp = state.supplements;
    emit(TopicPageState.loading(supp));
    final values = await service.getTopic(topicId);
    supp = supp.copyWith(topics: values['topics'], lessons: values['lessons']);
    emit(TopicPageState.content(supp));
  }
}
