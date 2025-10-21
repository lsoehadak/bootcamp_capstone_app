import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffix;
  final int line;
  final TextInputType keyboardType;
  final bool isDigitOnly;
  final Function(String)? onSubmit;
  final Function(String)? onChanged;

  const CustomDefaultTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.suffix,
    this.line = 1,
    this.keyboardType = TextInputType.text,
    this.isDigitOnly = false,
    this.onSubmit,
    this.onChanged,
  });

  OutlineInputBorder getMyInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.borderColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: line,
      maxLines: line,
      style: AppTextStyles.bodyText,
      keyboardType: keyboardType,
      inputFormatters: isDigitOnly
          ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))]
          : null,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: Center(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: suffix,
          ),
        ),
        border: getMyInputBorder(),
        enabledBorder: getMyInputBorder(),
        focusedBorder: getMyInputBorder(),
        errorBorder: getMyInputBorder(),
        focusedErrorBorder: getMyInputBorder(),
      ),
      onSubmitted: onSubmit,
      onChanged: onChanged,
    );
  }
}

class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isObscure;
  final Function() onReveal;
  final Function(String)? onChanged;

  const CustomPasswordTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.isObscure,
    required this.onReveal,
    this.onChanged,
  });

  OutlineInputBorder getMyInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.borderColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: AppTextStyles.bodyText,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        suffixIcon: isObscure
            ? IconButton(
                onPressed: onReveal,
                icon: const Icon(Icons.visibility),
              )
            : IconButton(
                onPressed: onReveal,
                icon: const Icon(Icons.visibility_off),
              ),
        border: getMyInputBorder(),
        enabledBorder: getMyInputBorder(),
        focusedBorder: getMyInputBorder(),
        errorBorder: getMyInputBorder(),
        focusedErrorBorder: getMyInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
