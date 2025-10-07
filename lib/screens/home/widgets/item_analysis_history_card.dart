import 'package:capstone_app/models/analysis_history.dart';
import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:capstone_app/screens/common/widgets/custom_card.dart';
import 'package:capstone_app/widgets/name_avatar.dart';
import 'package:flutter/material.dart';

import '../../../utils/date_time_utils.dart';
import '../../common/widgets/custom_divider.dart';

class ItemAnalysisHistoryCard extends StatelessWidget {
  final AnalysisHistory history;

  const ItemAnalysisHistoryCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return CustomDefaultCard(
      padding: EdgeInsets.zero,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusSection(),
          _buildAnalysisHistorySection(),
          _buildDetailButton(),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: history.nutritionalStatus.color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Text(
        'Status : ${history.nutritionalStatus.label}',
        style: AppTextStyles.captionText.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAnalysisHistorySection() {
    return Padding(
      padding: EdgeInsetsGeometry.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              NameAvatar(name: history.name),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(history.name, style: AppTextStyles.bodyHiEmText),
                    Text(history.gender, style: AppTextStyles.captionLowEmText),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const DashedDivider(),
          const SizedBox(height: 12),
          _buildRowFormattedInfo('Usia Anak', '${history.ageInMonth} bulan'),
          const SizedBox(height: 8),
          _buildRowFormattedInfo('Tinggi Badan', '${history.height} cm'),
          const SizedBox(height: 8),
          _buildRowFormattedInfo('Berat Badan', '${history.weight} kg'),
          const SizedBox(height: 12),
          const DashedDivider(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tanggal Analisa', style: AppTextStyles.captionLowEmText),
              Text(
                formatDateToString(history.date),
                style: AppTextStyles.captionLowEmText,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRowFormattedInfo(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodySmallText),
        Text(value, style: AppTextStyles.bodySmallText),
      ],
    );
  }

  Widget _buildDetailButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.mainThemeColor.withOpacity(0.3),
            AppColors.mainThemeColor.withOpacity(0.1),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Detail Analisa',
            style: AppTextStyles.bodySmallText.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 12, color: Colors.black),
        ],
      ),
    );
  }
}
