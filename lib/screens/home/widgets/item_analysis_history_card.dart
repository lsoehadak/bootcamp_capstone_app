import 'package:capstone_app/models/analysis_history.dart';
import 'package:capstone_app/screens/common/widgets/custom_card.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../utils/date_time_utils.dart';
import '../../common/widgets/custom_divider.dart';

class ItemAnalysisHistoryCard extends StatelessWidget {
  final AnalysisHistory history;
  final Function() onClick;
  final Function() onDelete;

  const ItemAnalysisHistoryCard({
    super.key,
    required this.history,
    required this.onClick,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onClick,
      child: CustomDefaultCard(
        padding: EdgeInsets.zero,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAnalysisHistorySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: history.nutritionalStatus.color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        history.nutritionalStatus.label,
        style: AppTextStyles.captionText.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAnalysisHistorySection() {
    return Padding(
      padding: const EdgeInsetsGeometry.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildStatusSection(), _buildDeleteButton()],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(history.name, style: AppTextStyles.bodyHiEmText),
                    const SizedBox(height: 4),
                    Text(
                      '${history.gender} | ${history.ageInMonth} bulan',
                      style: AppTextStyles.bodySmallLowEmText,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const DashedDivider(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tanggal Analisa', style: AppTextStyles.bodySmallText),
              Text(
                formatDateToString(history.date),
                style: AppTextStyles.bodySmallText,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onDelete,
      child: const CircleAvatar(
        radius: 16,
        backgroundColor: Color(0xFFF5F5F5),
        child: Icon(Icons.delete_rounded, color: Colors.grey, size: 16),
      ),
    );
  }
}
