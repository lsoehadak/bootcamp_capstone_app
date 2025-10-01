import 'package:capstone_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const titleText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const bodyHiEmText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const bodyText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const bodyLowEmText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.lowEmTextColor,
  );

  static const bodySmallText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const bodySmallLowEmText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.lowEmTextColor,
  );

  static const captionText = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const captionLowEmText = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.lowEmTextColor,
  );

  static const labelText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const sectionTitleText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}
