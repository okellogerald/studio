import '../source.dart';

class TopicPage extends StatefulWidget {
  const TopicPage(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.topicId})
      : super(key: key);

  final String title, subtitle, topicId;

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage>
    with SingleTickerProviderStateMixin {
  late final TopicPageBloc bloc;
  late final TabController controller;

  @override
  void initState() {
    controller = TabController(length: 5, vsync: this, initialIndex: 1);
    final service = Provider.of<CoursesService>(context, listen: false);
    bloc = TopicPageBloc(service);
    bloc.init(widget.topicId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(190.dh),
      child: BlocBuilder<TopicPageBloc, TopicPageState>(
          bloc: bloc,
          builder: (_, state) {
            return TopicPageAppBar(
                title: widget.title,
                subtitle: widget.subtitle,
                controller: controller,
                currentFilterType: state.supplements.filterType,
                onPressed: bloc.updateFilterType);
          }),
    );
  }

  _buildBody() {
    return BlocBuilder<TopicPageBloc, TopicPageState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              failed: _buildFailed);
        });
  }

  Widget _buildLoading(TopicPageSupplements supp, String? message) {
    return Scaffold(body: AppLoadingIndicator(message));
  }

  Widget _buildContent(TopicPageSupplements supp) {
    final idList = supp.getTopicsIdList;
    final lessonList = _getLessons(supp.lessons, supp.filterType);
    if (lessonList.isEmpty) return _buildEmptyState();
    return ListView.builder(
      padding: EdgeInsets.only(top: 20.dh, bottom: 20.dh),
      itemBuilder: (context, i) {
        final topicId = idList[i];
        final lessons = lessonList.where((e) => e.topicId == topicId).toList();
        if (lessons.isEmpty) return Container();
        return _buildLessons(lessons);
      },
      itemCount: idList.length,
      shrinkWrap: true,
    );
  }

  _buildLessons(List<Lesson> lessons) {
    final subTopicName = lessons.first.topicName;

    return Padding(
      padding: EdgeInsets.only(left: 15.dw, right: 15.dw, bottom: 15.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(subTopicName, weight: FontWeight.bold, size: 18.dw),
          SizedBox(height: 15.dh),
          ListView.separated(
            separatorBuilder: (_, __) => SizedBox(height: 10.dh),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              final subtitle =
                  '${lesson.videoTime} | ${lesson.type == LessonType.learn ? 'LEARN' : 'PRACTICE'}';
              return LessonTile(
                title: lesson.title,
                image: Constants.kDefaultImage,
                subtitle: subtitle,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => LessonPage(lesson.id))),
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  List<Lesson> _getLessons(List<Lesson> lessons, FilterType filterType) {
    switch (filterType) {
      case FilterType.learn:
        return lessons.where((e) => e.type == LessonType.learn).toList();
      case FilterType.practice:
        return lessons.where((e) => e.type == LessonType.practice).toList();
      case FilterType.free:
        return lessons.where((e) => e.isPaid == null).toList();
      case FilterType.paid:
        return lessons.where((e) => e.isPaid != null).toList();
      default:
        return lessons;
    }
  }

  _buildEmptyState() {
    return const Center(
      child: AppText('No lesson matches the filters.'),
    );
  }

  Widget _buildFailed(TopicPageSupplements supp, String message) {
    return Scaffold(
        body: FailedStateWidget(message,
            tryAgainCallback: () => bloc.init(widget.topicId),
            title: 'Failed to load the topic'));
  }
}
