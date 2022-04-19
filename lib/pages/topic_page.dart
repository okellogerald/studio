import 'package:silla_studio/manager/topic_page/models/sub_topic.dart';
import 'package:silla_studio/manager/topic_page/providers/providers.dart';
import 'package:silla_studio/manager/user_action.dart';
import '../manager/topic_page/models/topic.dart';
import '../manager/topic_page/providers/state_notifier.dart';
import '../widgets/failed_state_widget.dart';
import '../widgets/lesson_tile.dart';
import '../widgets/topic_page_app_bar.dart';
import 'source.dart';

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
    tabController = TabController(length: 6, vsync: this, initialIndex: 0);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(currentTopicProvider.state).state = widget.topic;
      ref.refresh(currentFilterProvider);
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
          child: subtopics.isEmpty
              ? const Center(child: AppText('No lesson matches the filter.'))
              : ListView.builder(
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
}
