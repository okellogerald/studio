import '../source.dart';

class AppTextField extends StatefulWidget {
  const AppTextField(
      {required this.error,
      required this.text,
      required this.onChanged,
      this.maxLines = 1,
      required this.hintText,
      required this.keyboardType,
      this.textCapitalization = TextCapitalization.none,
      required this.label,
      this.letterSpacing,
      this.isPassword = false,
      this.isLoginPassword = false,
      this.shouldShowErrorText = true,
      Key? key})
      : super(key: key);

  final String? error;
  final String? text;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final String hintText, label;
  final double? letterSpacing;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool isPassword, isLoginPassword, shouldShowErrorText;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final controller = TextEditingController();
  final isVisibleNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    final text = widget.text ?? '';
    final isEditing = text.trim().isNotEmpty;
    if (isEditing) {
      controller.text = text;
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.error != null;
    final border = hasError ? _errorBorder : _inputBorder;

    return Padding(
      padding: EdgeInsets.only(left: 19.dw, right: 19.dw, bottom: 20.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(widget.label, opacity: .7),
          Container(
            height: 40.dh,
            margin: EdgeInsets.only(top: 8.dh),
            child: ValueListenableBuilder<bool>(
                valueListenable: isVisibleNotifier,
                builder: (context, isVisible, snapshot) {
                  return TextField(
                      controller: controller,
                      onChanged: widget.onChanged,
                      maxLines: widget.maxLines,
                      minLines: 1,
                      keyboardType: widget.keyboardType,
                      textCapitalization: widget.textCapitalization,
                      style: TextStyle(
                        color: AppColors.onBackground,
                        letterSpacing: widget.letterSpacing,
                        fontSize: 16.dw,
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: AppColors.primary,
                      obscureText: widget.isLoginPassword
                          ? true
                          : widget.isPassword && !isVisible,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: TextStyle(
                            color: AppColors.onBackground.withOpacity(.5),
                            fontSize: 16.dw,
                            fontWeight: FontWeight.w100,
                          ),
                          fillColor: AppColors.surface,
                          suffixIcon: _suffixIcon(isVisible),
                          filled: true,
                          isDense: true,
                          border: border,
                          focusedBorder: border,
                          enabledBorder: border,
                          contentPadding: EdgeInsets.only(left: 8.dw, top: 10.dh)));
                }),
          ),
          _buildError(),
        ],
      ),
    );
  }

  _buildError() {
    final hasError = widget.error != null;

    return hasError && widget.shouldShowErrorText
        ? Padding(
            padding: EdgeInsets.only(top: 8.dw),
            child: AppText(
              widget.error!,
              color: AppColors.error,
              size: 14.dw,
            ),
          )
        : Container();
  }

  _suffixIcon(bool isVisible) {
    final hasNoText = controller.text.isEmpty;
    final emptyContainer = Container(width: 0.01);

    return hasNoText
        ? emptyContainer
        : widget.isPassword
            ? GestureDetector(
                onTap: () => isVisibleNotifier.value = !isVisible,
                child: Icon(
                    !isVisible ? Icons.visibility : Icons.visibility_off,
                    size: 16.dw,
                    color: AppColors.accent),
              )
            : emptyContainer;
  }

  final _inputBorder = const UnderlineInputBorder(
      borderSide: BorderSide(width: 0.0, color: Colors.transparent),
      borderRadius: BorderRadius.zero);

  final _errorBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(width: 1.2, color: AppColors.error));
}
