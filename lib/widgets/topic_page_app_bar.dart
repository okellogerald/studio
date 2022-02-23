import '../source.dart';

class TopicPageAppBar extends StatefulWidget {
  const TopicPageAppBar(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.tabController,
      required this.scrollController,
      required this.currentFilterType,
      required this.onPressed})
      : super(key: key);

  final String title;
  final String subtitle;
  final TabController tabController;
  final ValueChanged<int> onPressed;
  final FilterType currentFilterType;
  final ScrollController scrollController;

  @override
  State<TopicPageAppBar> createState() => _TopicPageAppBarState();
}

class _TopicPageAppBarState extends State<TopicPageAppBar> {
  final scrollValueNotifier = ValueNotifier<double>(0.0);

  @override
  void initState() {
    widget.scrollController.addListener(() => _handleScrollUpdates());
    super.initState();
  }

  _handleScrollUpdates() {
    scrollValueNotifier.value = widget.scrollController.position.pixels;
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
    return AppText(widget.title,
        style: Theme.of(context)
            .appBarTheme
            .titleTextStyle!
            .copyWith(color: AppColors.secondary, fontSize: 24.dw));
  }

  _buildSubtitle() {
    return Padding(
      padding: EdgeInsets.only(top: 5.dh, left: 15.dw),
      child: AppText(widget.subtitle, opacity: .7),
    );
  }

  _buildTabBar(double value) {
    return Container(
      padding: EdgeInsets.only(top: 5.dh),
      margin: EdgeInsets.only(top: 5.dh),
      width: ScreenSizeConfig.getFullWidth,
      decoration: BoxDecoration(
          color: value == 0
              ? AppColors.surface.withOpacity(.5)
              : AppColors.primary),
      child: TabBar(
          controller: widget.tabController,
          padding: const EdgeInsets.only(left: 19),
          isScrollable: true,
          onTap: widget.onPressed,
          indicatorColor: AppColors.accent,
          indicatorWeight: 4.dw,
          tabs: [
            _buildTabItem('All', FilterType.all, value),
            _buildTabItem('Learn', FilterType.learn, value),
            _buildTabItem('Practice', FilterType.practice, value),
            _buildTabItem('Free', FilterType.free, value),
            _buildTabItem('Paid', FilterType.paid, value),
          ]),
    );
  }

  _buildTabItem(String value, FilterType filterStyle, double scrollValue) {
    final isSelected = widget.currentFilterType == filterStyle;
    return AppText(value,
        color: scrollValue == 0 ? AppColors.onBackground : AppColors.onPrimary,
        weight: isSelected ? FontWeight.bold : FontWeight.normal);
  }
}
