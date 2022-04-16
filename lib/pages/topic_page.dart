import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:silla_studio/manager/courses/topic_page.dart';
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
  Widget build(BuildContext context) {
    final lessonsProvider = ref.read(topicLessonsProvider(widget.topic.id));

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            body: lessonsProvider.when(
                data: _buildContent,
                error: (message, _) => FailedStateWidget(message.toString()),
                loading: () =>
                    const AppLoadingIndicator('Getting lessons...'))),
      ),
    );
  }

  _buildHeader() {
    return TopicPageAppBar(
        topic: widget.topic,
        tabController: tabController,
        scrollController: scrollController);
  }

  Widget _buildContent(List<Lesson> lessons) {
    final idList = ref.read(subTopicsIdsProvider(lessons));
    final filteredLessons = ref.watch(filteredLessonsProvider(lessons));
    if (filteredLessons.isEmpty) return _buildEmptyState();
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 20.dh),
            itemBuilder: (context, i) {
              final topicId = idList[i];
              final lessons =
                  filteredLessons.where((e) => e.topicId == topicId).toList();
              if (lessons.isEmpty) return Container();
              return _buildLessons(filteredLessons);
            },
            itemCount: idList.length,
            shrinkWrap: true,
            controller: scrollController,
          ),
        ),
      ],
    );
  }

  _buildLessons(List<Lesson> lessons) {
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
                LessonTile(lessons[index]),
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
