import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';

class EmptyStateView extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String message;

  const EmptyStateView({
    super.key,
    this.imagePath,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(imagePath!),
                ),
              ),
            Text(title, style: AppTextStyles.titleText.copyWith(fontSize: 20)),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLowEmText,
            ),
          ],
        ),
      ),
    );
  }
}
