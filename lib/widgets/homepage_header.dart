import '../source.dart';

class HomepageHeader extends StatefulWidget {
  const HomepageHeader(this.controller,
      {required this.title,
      required this.subtitle,
      required this.trailing,
      Key? key})
      : super(key: key);

  final String title, subtitle;
  final Widget trailing;
  final ScrollController controller;

  @override
  State<HomepageHeader> createState() => _HomepageHeaderState();
}

class _HomepageHeaderState extends State<HomepageHeader> {
  final scrollValueNotifier = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() => _handleScrollUpdates());
  }

  _handleScrollUpdates() {
    final value = widget.controller.position.pixels;
    scrollValueNotifier.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
        valueListenable: scrollValueNotifier,
        builder: (_, value, child) {
          return Container(
            height: value == 0 ? 120.dh : 65.dh,
            padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5.dh),
            decoration: BoxDecoration(
                border: value == 0
                    ? const Border()
                    : const Border(
                        bottom: BorderSide(width: 1.5, color: Colors.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitles(value),
                widget.trailing,
              ],
            ),
          );
        });
  }

  _buildTitles(double value) {
    return Expanded(
      child: Container(
        alignment: value == 0
            ? AlignmentDirectional.bottomStart
            : AlignmentDirectional.centerStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(widget.title,
                style: Theme.of(context)
                    .appBarTheme
                    .titleTextStyle!
                    .copyWith(fontSize: 20.dw)),
            AppText(widget.subtitle, opacity: .85, size: 14.dw),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
