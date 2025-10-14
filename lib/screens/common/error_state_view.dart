import 'package:capstone_app/screens/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';

class ErrorStateView extends StatelessWidget {
  final String title;
  final String message;
  final Function() onRefresh;

  const ErrorStateView({
    super.key,
    required this.title,
    required this.message,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: AppTextStyles.titleText.copyWith(fontSize: 20)),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLowEmText,
            ),
            const SizedBox(height: 16),
            CustomDefaultButton(label: 'Muat Ulang', onClick: onRefresh),
          ],
        ),
      ),
    );
  }
}
