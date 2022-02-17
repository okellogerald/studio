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
            height: value == 0 ? 170.dh : 90.dh,
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
          iconThemeData: Theme.of(context)
              .iconTheme
              .copyWith(color: AppColors.onBackground),
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
        style: Theme.of(context).appBarTheme.titleTextStyle!);
  }

  _buildSubtitle() {
    return Padding(
      padding: EdgeInsets.only(top: 10.dh, left: 15.dw),
      child: AppText(widget.subtitle, opacity: .7),
    );
  }

  _buildTabBar() {
    return SizedBox(
      height: 52.dh,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(border: border),
                padding: EdgeInsets.only(left: 15.dw, right: 15.dw),
                child: AppText('FILTERS', size: 16.dw, weight: FontWeight.bold),
              ),
              _buildFilters(),
            ],
          ),
          const AppDivider(margin: EdgeInsets.zero)
        ],
      ),
    );
  }

  _buildFilters() {
    return Expanded(
      child: TabBar(
          controller: widget.tabController,
          indicatorColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 0.001,
          padding: EdgeInsets.only(left: 10.dw),
          onTap: widget.onPressed,
          isScrollable: true,
          tabs: [
            _buildTab('All', FilterType.all, widget.currentFilterType),
            _buildTab('Learn', FilterType.learn, widget.currentFilterType),
            _buildTab(
                'Practice', FilterType.practice, widget.currentFilterType),
            _buildTab('Free', FilterType.free, widget.currentFilterType),
            _buildTab('Paid', FilterType.paid, widget.currentFilterType),
          ]),
    );
  }

  _buildTab(String title, FilterType filterType, FilterType currentFilterType) {
    final isSelected = filterType == currentFilterType;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.dw),
      decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.all(Radius.circular(5.dw))),
      height: 30.dh,
      alignment: Alignment.center,
      child: AppText(title,
          color: isSelected ? AppColors.onPrimary : AppColors.onBackground,
          opacity: isSelected ? 1 : .7),
    );
  }

  static const border =
      Border(right: BorderSide(width: 1.5, color: AppColors.divider));
}
