import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../manager/courses/topic_page/providers.dart';
import '../manager/courses/topic_page/user_actions.dart';
import '../source.dart' hide Consumer;

class TopicPageAppBar extends ConsumerStatefulWidget {
  const TopicPageAppBar({
    Key? key,
    required this.topic,
    required this.tabController,
    required this.scrollController,
  }) : super(key: key);

  final Topic topic;
  final TabController tabController;
  final ScrollController scrollController;

  @override
  ConsumerState<TopicPageAppBar> createState() => _TopicPageAppBarState();
}

class _TopicPageAppBarState extends ConsumerState<TopicPageAppBar> {
  final scrollValueNotifier = ValueNotifier<double>(0.0);

  @override
  void initState() {
    widget.scrollController.addListener(() => _handleScrollUpdates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
        valueListenable: scrollValueNotifier,
        builder: (_, value, snapshot) {
          return Container(
            height: value == 0 ? 170.dh : 100.dh,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackIconButton(value),
                const Spacer(),
                value == 0
                    ? Padding(
                        padding: EdgeInsets.only(left: 15.dw),
                        child: _buildTitle(),
                      )
                    : Container(),
                value == 0 ? _buildSubtitle() : Container(),
                _buildTabBar(value)
              ],
            ),
          );
        });
  }

  _buildBackIconButton(double value) {
    return Row(
      children: [
        AppIconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icons.arrow_back,
          margin: EdgeInsets.only(left: 15.dw, top: 5.dh, right: 15.dw),
          iconThemeData: Theme.of(context).iconTheme,
        ),
        value == 0
            ? Container()
            : Padding(
                padding: EdgeInsets.only(top: 5.dh),
                child: _buildTitle(),
              ),
      ],
    );
  }

  Widget _buildTitle() {
    return AppText(widget.topic.title,
        style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
            color: AppColors.secondary,
            fontSize: 24.dw,
            fontWeight: FontWeight.w900));
  }

  _buildSubtitle() {
    final completedCount = ref.read(topicCompletedCountProvider);
    final subtitle =
        '$completedCount / ${widget.topic.totalLessons} videos completed';
    return Padding(
      padding: EdgeInsets.only(top: 5.dh, left: 15.dw),
      child: AppText(subtitle, opacity: .7),
    );
  }

  _buildTabBar(double value) {
    return Container(
        padding: EdgeInsets.only(top: 5.dh),
        margin: EdgeInsets.only(top: 5.dh),
        width: ScreenSizeConfig.getFullWidth,
        decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(.5),
            border: value == 0
                ? Border.all(color: Colors.transparent, width: 0)
                : const Border(
                    bottom: BorderSide(width: 1.5, color: AppColors.divider))),
        child: TabBar(
            controller: widget.tabController,
            padding: const EdgeInsets.only(left: 19),
            isScrollable: true,
            onTap: (index) => handleSelectedFilter(ref, index),
            indicatorColor: AppColors.accent,
            indicatorWeight: 4.dw,
            tabs: [
              _buildTabItem('All', LessonsFilter.all),
              _buildTabItem('Learn', LessonsFilter.learn),
              _buildTabItem('Practice', LessonsFilter.practice),
              _buildTabItem('Free', LessonsFilter.free),
              _buildTabItem('Paid', LessonsFilter.paid)
            ]));
  }

  _buildTabItem(String value, LessonsFilter filterStyle) {
    final currentFilter = ref.watch(currentFilterProvider);
    final isSelected = currentFilter == filterStyle;
    return AppText(value,
        opacity: isSelected ? 1 : .7,
        weight: isSelected ? FontWeight.bold : FontWeight.normal);
  }

  _handleScrollUpdates() {
    scrollValueNotifier.value = widget.scrollController.position.pixels;
  }
}
