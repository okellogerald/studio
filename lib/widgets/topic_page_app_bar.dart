import '../source.dart';

class TopicPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopicPageAppBar(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.controller,
      required this.currentFilterType,
      required this.onPressed})
      : super(key: key);

  final String title;
  final String subtitle;
  final TabController controller;
  final ValueChanged<int> onPressed;
  final FilterType currentFilterType;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: TopicPageAppBarBottom(
        title: title,
        subtitle: subtitle,
        controller: controller,
        onPressed: onPressed,
        currentFilterType: currentFilterType,
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 190.dh);
}

class TopicPageAppBarBottom extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final TabController controller;
  final ValueChanged<int> onPressed;
  final FilterType currentFilterType;

  const TopicPageAppBarBottom(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.controller,
      required this.currentFilterType,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.dw),
            child: AppText(title,
                style: Theme.of(context).appBarTheme.titleTextStyle!),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.dh, left: 15.dw),
            child: AppText(subtitle, opacity: .7),
          ),
          _buildTabBar()
        ],
      ),
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
                decoration: const BoxDecoration(
                    border: Border(
                        right:
                            BorderSide(width: 1.5, color: AppColors.divider))),
                padding: EdgeInsets.only(left: 15.dw, right: 15.dw),
                child: AppText('FILTERS', size: 16.dw, weight: FontWeight.bold),
              ),
              Expanded(
                child: TabBar(
                    controller: controller,
                    indicatorColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 0.001,
                    padding: EdgeInsets.only(left: 10.dw),
                    onTap: onPressed,
                    isScrollable: true,
                    tabs: [
                      _buildTab('All', FilterType.all, currentFilterType),
                      _buildTab('Learn', FilterType.learn, currentFilterType),
                      _buildTab(
                          'Practice', FilterType.practice, currentFilterType),
                      _buildTab('Free', FilterType.free, currentFilterType),
                      _buildTab('Paid', FilterType.paid, currentFilterType),
                    ]),
              ),
            ],
          ),
          const AppDivider(margin: EdgeInsets.zero)
        ],
      ),
    );
  }

  _buildTab(String title, FilterType filterType, FilterType currentFilterType) {
    final isSelected = filterType == currentFilterType;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.dw),
      decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.primaryVariant,
          borderRadius: BorderRadius.all(Radius.circular(5.dw))),
      height: 30.dh,
      alignment: Alignment.center,
      child: AppText(title,
          color: isSelected ? AppColors.onPrimary : AppColors.onBackground,
          opacity: isSelected ? 1 : .7),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.dh);
}
