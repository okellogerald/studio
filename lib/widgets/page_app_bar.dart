import '../source.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({Key? key, required this.title, this.subtitle})
      : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: AppBarBottom(title: title, subtitle: subtitle),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 130.dh);
}

class AppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;

  const AppBarBottom({Key? key, required this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.dh, left: 15.dw),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(title, style: Theme.of(context).appBarTheme.titleTextStyle!),
          subtitle != null
              ? Padding(
                  padding: EdgeInsets.only(top: 5.dh),
                  child: AppText(subtitle!,
                      style: Theme.of(context)
                          .appBarTheme
                          .titleTextStyle!
                          .copyWith(
                              fontSize: 16.dw,
                              color: AppColors.onBackground.withOpacity(.7))),
                )
              : SizedBox(height: 10.dh),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.dh);
}
