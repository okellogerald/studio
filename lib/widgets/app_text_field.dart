import 'package:silla_studio/utils/validation_logic.dart';

import 'source.dart';

enum ValueType { email, name, password, confirmationPassword }

class AppTextField extends StatefulWidget {
  const AppTextField(
      {required this.type,
      required this.onChanged,
      required this.text,
      this.password,
      this.maxLines = 1,
      required this.hintText,
      required this.keyboardType,
      this.textCapitalization = TextCapitalization.none,
      required this.label,
      this.isPassword = false,
      this.isLoginPassword = false,
      Key? key})
      : super(key: key);

  final ValueType type;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final String hintText, label, text;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool isPassword;

  //if password is given, then the text entered is used for comparison with this
  //password
  final String? password;

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
    final text = widget.text;
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
    return Padding(
      padding: EdgeInsets.only(left: 15.dw, right: 15.dw, bottom: 20.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(widget.label, opacity: .7, size: 14.dw),
          Container(
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
                })
          )
        ]
      )
    );
  }

  String? _validate(String? value) {
    switch (widget.type) {
      case ValueType.email:
        return validateEmail(value);
      case ValueType.name:
        return validateText(value, widget.label);
      case ValueType.password:
        return validatePassword(value);
      case ValueType.confirmationPassword:
        return validatePasswords(widget.password, value);
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
