import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomDefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffix;
  final int line;
  final Function(String) onSubmit;

  const CustomDefaultTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.suffix,
    this.line = 1,
    required this.onSubmit,
  });

  OutlineInputBorder getMyInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.borderColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: line,
      maxLines: line,
      style: AppTextStyles.bodyText,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffix: suffix,
        border: getMyInputBorder(),
        enabledBorder: getMyInputBorder(),
        focusedBorder: getMyInputBorder(),
        errorBorder: getMyInputBorder(),
        focusedErrorBorder: getMyInputBorder(),
      ),
      onSubmitted: onSubmit,
    );
  }
}

class CustomPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isObscure;
  final Function() onReveal;

  const CustomPasswordTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.isObscure,
    required this.onReveal,
  });

  OutlineInputBorder getMyInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.borderColor),
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
        suffixIcon: isObscure ? IconButton(
          onPressed: onReveal,
          icon: const Icon(Icons.visibility_off),
        ) : IconButton(
          onPressed: onReveal,
          icon: const Icon(Icons.visibility),
        ),
        border: getMyInputBorder(),
        enabledBorder: getMyInputBorder(),
        focusedBorder: getMyInputBorder(),
        errorBorder: getMyInputBorder(),
        focusedErrorBorder: getMyInputBorder(),
      ),
    );
  }
}
