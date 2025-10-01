import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class NameAvatar extends StatelessWidget {
  final String name;

  const NameAvatar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.borderColor,
      radius: 20,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.mainThemeColor,
        child: Center(
          child: Text(
            name[0],
            style: AppTextStyles.titleText.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
