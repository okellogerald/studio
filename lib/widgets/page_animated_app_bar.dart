import '../source.dart';

class PageAnimatedAppBar extends StatefulWidget {
  const PageAnimatedAppBar(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.scrollController})
      : super(key: key);

  final String title, subtitle;
  final ScrollController scrollController;

  @override
  State<PageAnimatedAppBar> createState() => _PageAnimatedAppBarState();
}

class _PageAnimatedAppBarState extends State<PageAnimatedAppBar> {
  final scrollValueNotifier = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() => _handleScrollController());
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
        valueListenable: scrollValueNotifier,
        builder: (_, value, snapshot) {
          final isScrolled = value == 0;

          return Container(
            height: isScrolled ? 135.dh : 45.dh,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(
                    bottom: isScrolled
                        ? const BorderSide(width: 0, color: Colors.transparent)
                        : const BorderSide(
                            width: 1.5, color: AppColors.divider))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackIconButton(isScrolled),
                const Spacer(),
                isScrolled
                    ? Padding(
                        padding: EdgeInsets.only(left: 15.dw),
                        child: _buildTitle(isScrolled),
                      )
                    : Container(),
                isScrolled ? _buildSubtitle() : Container(),
              ],
            ),
          );
        });
  }

  _buildBackIconButton(bool isScrolled) {
    return Row(
      children: [
        AppIconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icons.arrow_back,
          margin: EdgeInsets.only(left: 15.dw, top: 5.dh, right: 15.dw),
          iconThemeData: Theme.of(context).iconTheme,
        ),
        isScrolled
            ? Container()
            : Padding(
                padding: EdgeInsets.only(top: 5.dh),
                child: _buildTitle(isScrolled),
              ),
      ],
    );
  }

  Widget _buildTitle(bool isScrolled) {
    return AppText(widget.title,
        style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
            color: AppColors.secondary,
            fontSize: !isScrolled ? 20.dw : 24.dw,
            fontWeight: FontWeight.bold));
  }

  _buildSubtitle() {
    return Padding(
      padding: EdgeInsets.only(top: 5.dh, left: 15.dw),
      child: AppText(widget.subtitle, opacity: .7),
    );
  }

  _handleScrollController() {
    scrollValueNotifier.value = widget.scrollController.position.pixels;
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }
}
