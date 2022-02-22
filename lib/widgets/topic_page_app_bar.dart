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
            height: value == 0 ? 170.dh : 95.dh,
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
                _buildTabBar()
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
            .copyWith(color: AppColors.secondary));
  }

  _buildSubtitle() {
    return Padding(
      padding: EdgeInsets.only(top: 5.dh, left: 15.dw),
      child: AppText(widget.subtitle, opacity: .7),
    );
  }

  _buildTabBar() {
    return Container(
      color: AppColors.surface.withOpacity(.5),
      padding: EdgeInsets.only(top: 5.dh),
      margin: EdgeInsets.only(top: 5.dh),
      width: ScreenSizeConfig.getFullWidth,
      child: TabBar(
          controller: widget.tabController,
          padding: const EdgeInsets.only(left: 19),
          isScrollable: true,
          onTap: widget.onPressed,
          tabs: [
            _buildTabItem('All', FilterType.all),
            _buildTabItem('Learn', FilterType.learn),
            _buildTabItem('Practice', FilterType.practice),
            _buildTabItem('Free', FilterType.free),
            _buildTabItem('Paid', FilterType.paid),
          ]),
    );
  }

  _buildTabItem(String value, FilterType filterStyle) {
    final isSelected = widget.currentFilterType == filterStyle;
    return AppText(value,
        weight: isSelected ? FontWeight.bold : FontWeight.normal);
  }
}
