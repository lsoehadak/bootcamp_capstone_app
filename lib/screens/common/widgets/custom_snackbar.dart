import 'package:flutter/material.dart';

import '../../../utils/app_text_styles.dart';

void showSnackBar(BuildContext context, String title, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyHiEmText.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: AppTextStyles.bodySmallText.copyWith(color: Colors.white),
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
