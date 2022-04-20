import 'package:silla_studio/utils/validation_logic.dart';

import 'source.dart';

enum ValueType { email, name, password }

class AppTextField extends StatefulWidget {
  const AppTextField(
      {required this.type,
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

  final ValueType type;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final String hintText, label;
  final double? letterSpacing;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool isPassword, shouldShowErrorText;

  /// does not show the eye suffix icon
  final bool isLoginPassword;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final controller = TextEditingController();
  final isVisibleNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    /*   final text = widget.text ?? '';
    final isEditing = text.trim().isNotEmpty;
    if (isEditing) {
      controller.text = text;
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    } */

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    final border = hasError ? errorBorder : inputBorder;

    return Padding(
      padding: EdgeInsets.only(left: 15.dw, right: 15.dw, bottom: 20.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(widget.label, opacity: .7, size: 14.dw),
          Container(
            height: 40.dh,
            margin: EdgeInsets.only(top: 8.dh),
            child: ValueListenableBuilder<bool>(
                valueListenable: isVisibleNotifier,
                builder: (context, isVisible, snapshot) {
                  return TextFormField(
                      controller: controller,
                      onChanged: widget.onChanged,
                      maxLines: widget.maxLines,
                      minLines: 1,
                      keyboardType: widget.keyboardType,
                      textCapitalization: widget.textCapitalization,
                      style: valueStyle,
                      cursorColor: AppColors.primary,
                      validator: _validate,
                      obscureText: widget.isLoginPassword
                          ? true
                          : widget.isPassword && !isVisible,
                      decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: hintStyle,
                          fillColor: AppColors.surface,
                          suffixIcon: _suffixIcon(isVisible),
                          filled: true,
                          isDense: true,
                          border: inputBorder,
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          errorBorder: errorBorder,
                          contentPadding: EdgeInsets.only(left: 10.dw)));
                }),
          ),
          // _buildError(),
        ],
      ),
    );
  }

/*   _buildError() {
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
  } */

  String? _validate(String? value) {
    switch (widget.type) {
      case ValueType.email:
        return validateEmail(value);
      case ValueType.name:
        return validateText(value, widget.label);
      case ValueType.password:
        return validatePassword(value);
      default:
    }
    return null;
  }

  _suffixIcon(bool isVisible) {
    final hasNoText = controller.text.isEmpty;
    final emptyContainer = Container(width: 0.01);

    return hasNoText || widget.isLoginPassword
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
}
