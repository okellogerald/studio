import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;

import '../errors/app_error.dart';
import '../manager/user/user_actions.dart';
import '../source.dart';

class TopicPage extends ConsumerStatefulWidget {
  const TopicPage({Key? key, required this.topic}) : super(key: key);

  final Topic topic;

  @override
  ConsumerState<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends ConsumerState<TopicPage>
    with SingleTickerProviderStateMixin {
  late final TopicPageBloc bloc;
  late final TabController tabController;
  final scrollController = ScrollController();

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    final coursesService = Provider.of<CoursesService>(context, listen: false);
    final lessonsService = Provider.of<LessonsService>(context, listen: false);
    bloc = TopicPageBloc(coursesService, lessonsService);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(userActionProvider.state).state = UserActivity.topicLessonsView;
    });
    bloc.init(widget.topic);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<TopicPageBloc, TopicPageState>(
              bloc: bloc,
              listener: (context, state) {
                final error = state.maybeWhen(
                    failed: (_, error) => error, orElse: () => null);
                if (error != null && error.isShownViaSnackBar) {
                  showSnackbar(error.message);
                }
              },
              builder: (_, state) {
                return state.when(
                    loading: _buildLoading,
                    content: _buildContent,
                    failed: _buildFailed);
              }),
        ),
      ),
    );
  }

  _buildHeader() {
    return BlocBuilder<TopicPageBloc, TopicPageState>(
        bloc: bloc,
        builder: (_, state) {
          final completedCount = state.supplements.completedCount;
          final subtitle =
              '$completedCount / ${widget.topic.totalLessons} videos completed';

          return TopicPageAppBar(
              title: widget.topic.title,
              subtitle: subtitle,
              tabController: tabController,
              scrollController: scrollController,
              currentFilterType: state.supplements.filterType,
              onPressed: bloc.updateFilterType);
        });
  }

  Widget _buildLoading(TopicPageSupplements supp, String? message) {
    return Scaffold(body: AppLoadingIndicator(message));
  }

  Widget _buildContent(TopicPageSupplements supp) {
    final idList = supp.getTopicsIdList;
    final lessonList = _getLessons(supp.lessons, supp.filterType);
    if (lessonList.isEmpty) return _buildEmptyState();
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 20.dh),
            itemBuilder: (context, i) {
              final topicId = idList[i];
              final lessons =
                  lessonList.where((e) => e.topicId == topicId).toList();
              if (lessons.isEmpty) return Container();
              return _buildLessons(lessons, supp);
            },
            itemCount: idList.length,
            shrinkWrap: true,
            controller: scrollController,
          ),
        ),
      ],
    );
  }

  _buildLessons(List<Lesson> lessons, TopicPageSupplements supp) {
    final subTopicName = lessons.first.topicName;

    return Padding(
      padding: EdgeInsets.only(left: 15.dw, right: 15.dw, bottom: 20.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(subTopicName, weight: FontWeight.w500, size: 18.dw),
          SizedBox(height: 15.dh),
          ListView.separated(
            separatorBuilder: (_, __) => SizedBox(height: 10.dh),
            itemCount: lessons.length,
            itemBuilder: (context, index) =>
                LessonTile(lessons[index], supp.getLessonsIdList),
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
        return lessons.where((e) => !e.isPaid).toList();
      case FilterType.paid:
        return lessons.where((e) => e.isPaid).toList();
      default:
        return lessons;
    }
  }

  _buildEmptyState() {
    return const Center(
      child: AppText('No lesson matches the filters.'),
    );
  }

  Widget _buildFailed(TopicPageSupplements supp, AppError error) {
    if (error.isShownViaSnackBar) return _buildContent(supp);
    return Scaffold(
        body: FailedStateWidget(error.message,
            tryAgainCallback: () => bloc.init(widget.topic)));
  }
}
