import 'package:capstone_app/models/analysis_history.dart';
import 'package:capstone_app/screens/common/widgets/custom_button.dart';
import 'package:capstone_app/screens/common/widgets/custom_divider.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:capstone_app/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

class BottomSheetDeleteAnalysisHistory extends StatelessWidget {
  final AnalysisHistory analysisHistory;
  final Function() onDelete;
  final Function() onCancel;

  const BottomSheetDeleteAnalysisHistory({
    required this.analysisHistory,
    required this.onDelete,
    required this.onCancel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Hapus Riwayat Analisis',
              style: AppTextStyles.titleText.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 8),
            const Text(
              'Apakah Anda yakin ingin menghapus riwayat analisis anak ini?',
              style: AppTextStyles.bodyText,
            ),
            const SizedBox(height: 16),
            Text(analysisHistory.name, style: AppTextStyles.bodyHiEmText),
            const SizedBox(height: 4),
            Text(
              '${analysisHistory.gender} | ${analysisHistory.ageInMonth} bulan',
              style: AppTextStyles.bodySmallLowEmText,
            ),
            const SizedBox(height: 12),
            const DashedDivider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tanggal Analisis', style: AppTextStyles.bodySmallText),
                Text(
                  formatDateToString(analysisHistory.date),
                  style: AppTextStyles.bodySmallText,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(label: 'Batal', onClick: onCancel),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomDefaultButton(
                    label: 'Hapus',
                    backgroundColor: Colors.red,
                    onClick: onDelete,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
