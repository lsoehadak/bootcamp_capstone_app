import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomDefaultButton extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final Function onClick;
  final double radius;
  final double height;
  final bool isLoading;

  const CustomDefaultButton({
    super.key,
    required this.label,
    required this.onClick,
    this.isEnabled = true,
    this.radius = 8,
    this.height = 48,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isEnabled && !isLoading
          ? () {
              onClick();
            }
          : null,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(12),
        minimumSize: Size(double.infinity, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        backgroundColor: AppColors.mainThemeColor,
        disabledBackgroundColor: Colors.grey,
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              label,
              style: AppTextStyles.titleText.copyWith(color: Colors.white),
            ),
    );
  }
}

class CustomCompactOutlinedButton extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final Function onClick;
  final double radius;
  final double height;
  final TextStyle? textStyle;

  const CustomCompactOutlinedButton({
    super.key,
    required this.label,
    required this.onClick,
    this.isEnabled = true,
    this.radius = 8,
    this.height = 48,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isEnabled
          ? () {
              onClick();
            }
          : null,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        minimumSize: Size(0, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        side: BorderSide(color: AppColors.mainThemeColor),
        backgroundColor: Colors.white,
        disabledBackgroundColor: Colors.white,
      ),
      child: Text(
        label,
        style:
            textStyle ??
            AppTextStyles.titleText.copyWith(color: AppColors.mainThemeColor),
      ),
    );
  }
}
