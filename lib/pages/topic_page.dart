import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import '../manager/courses/models/sub_topic.dart';
import '../manager/courses/topic_page/providers.dart';
import '../manager/courses/topic_page/state_notifier.dart';
import '../manager/user_action.dart';
import '../source.dart';

class TopicPage extends ConsumerStatefulWidget {
  const TopicPage({Key? key, required this.topic}) : super(key: key);

  final Topic topic;

  @override
  ConsumerState<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends ConsumerState<TopicPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final scrollController = ScrollController();

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(currentTopicIdProvider.state).state = widget.topic.id;
      handleUserAction(ref, UserAction.viewTopic);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topicPageNotifier = ref.watch(topicPageNotifierProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
              body: topicPageNotifier.when(
                  loading: (message) => AppLoadingIndicator(message),
                  content: _buildContent,
                  failed: (message) => FailedStateWidget(message)))),
    );
  }

  _buildHeader() {
    return TopicPageAppBar(
        topic: widget.topic,
        tabController: tabController,
        scrollController: scrollController);
  }

  Widget _buildContent(List<SubTopic> subtopics) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 20.dh),
            itemBuilder: (context, i) {
              final subtopic = subtopics[i];
              if (subtopic.lessons.isEmpty) return Container();
              return _buildLessons(subtopic);
            },
            itemCount: subtopics.length,
            shrinkWrap: true,
            controller: scrollController,
          ),
        ),
      ],
    );
  }

  _buildLessons(SubTopic subtopic) {
    return Padding(
      padding: EdgeInsets.only(left: 15.dw, right: 15.dw, bottom: 20.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(subtopic.topic.title, weight: FontWeight.w500, size: 18.dw),
          SizedBox(height: 15.dh),
          ListView.separated(
            separatorBuilder: (_, __) => SizedBox(height: 10.dh),
            itemCount: subtopic.lessons.length,
            itemBuilder: (context, index) =>
                LessonTile(subtopic.lessons[index]),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  _buildEmptyState() {
    return const Center(
      child: AppText('No lesson matches the filters.'),
    );
  }
}
