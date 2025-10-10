import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class GenderChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function() onClick;

  const GenderChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainThemeColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.mainThemeColor : AppColors.borderColor,
          ),
        ),
        child: Text(
          label,
          style: isSelected
              ? AppTextStyles.bodyHiEmText.copyWith(color: Colors.white)
              : AppTextStyles.bodyLowEmText,
        ),
      ),
    );
  }
}
