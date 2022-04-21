import 'source.dart';

class AppTextButton extends StatefulWidget {
  const AppTextButton(
      {this.icon,
      this.padding,
      this.margin,
      this.height,
      this.width,
      this.text,
      this.alignment,
      this.child,
      this.withIcon = false,
      this.useBorder = false,
      this.textStyle,
      this.iconColor = AppColors.onBackground,
      this.textColor,
      this.borderRadius,
      this.backgroundColor,
      required this.onPressed,
      Key? key})
      : super(key: key);

  final IconData? icon;
  final double? width, borderRadius, height;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding, margin;
  final String? text;
  final bool withIcon, useBorder;
  final Widget? child;
  final Alignment? alignment;
  final TextStyle? textStyle;
  final Color? iconColor, textColor, backgroundColor;

  @override
  _AppTextButtonState createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Color?> animation;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 400),
        reverseDuration: const Duration(milliseconds: 0),
        vsync: this);
    animation = ColorTween(
            end: Colors.grey.withOpacity(.25),
            begin: widget.backgroundColor ?? Colors.transparent)
        .animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
          widget.onPressed();
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: _child(),
      builder: (context, child) {
        return GestureDetector(
          onTap: () => controller.forward(),
          child: Container(
              height: widget.height,
              width: widget.width,
              margin: widget.margin ?? EdgeInsets.zero,
              padding: widget.padding ?? EdgeInsets.zero,
              alignment: widget.alignment ?? Alignment.center,
              decoration: BoxDecoration(
                  color: animation.value,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(/* widget.borderRadius ?? */ 0))),
              child: child),
        );
      },
    );
  }

  _child() {
    final hasProvidedChild = widget.child != null;

    return hasProvidedChild
        ? widget.child
        : widget.withIcon
            ? Row(
                mainAxisAlignment: widget.alignment == Alignment.centerLeft
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                    Icon(widget.icon ?? Icons.share,
                        color: widget.iconColor ?? AppColors.primary,
                        size: 22.dw),
                    SizedBox(width: 15.dw),
                    _text(),
                  ])
            : _text();
  }

  _text() {
    return widget.textStyle != null
        ? Text(widget.text ?? 'click me', style: widget.textStyle)
        : AppText(
            widget.text ?? 'Click Me',
            color: widget.textColor,
            alignment: TextAlign.center,
          );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
