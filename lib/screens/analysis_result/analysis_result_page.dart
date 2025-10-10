import 'package:capstone_app/models/analysis_history.dart';
import 'package:capstone_app/screens/common/widgets/custom_button.dart';
import 'package:capstone_app/screens/common/widgets/custom_card.dart';
import 'package:capstone_app/screens/common/widgets/custom_dialog.dart';
import 'package:capstone_app/screens/common/widgets/custom_divider.dart';
import 'package:capstone_app/screens/home/home_page.dart';
import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/analysis_result_provider.dart';
import '../../utils/date_time_utils.dart';
import '../../utils/ui_state.dart';
import '../../widgets/name_avatar.dart';
import '../personalized_recommendation/personalized_recommendation_page.dart';

class AnalysisResultPage extends StatefulWidget {
  const AnalysisResultPage({super.key});

  @override
  State<AnalysisResultPage> createState() => _AnalysisResultPageState();
}

class _AnalysisResultPageState extends State<AnalysisResultPage> {
  @override
  Widget build(BuildContext context) {
    final resultState = context.watch<AnalysisResultProvider>().uiState;

    if (resultState is UiErrorState<bool>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorMessage(resultState.errorMessage);
      });
    } else if (resultState is UiSuccessState<bool>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _backToHomePage();
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Analisa')),
      body: SafeArea(
        top: false,
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Consumer<AnalysisResultProvider>(
            builder: (context, provider, child) {
              final history = provider.analysisHistory;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tanggal Analisa',
                        style: AppTextStyles.bodySmallText,
                      ),
                      Text(
                        formatDateToString(history.date),
                        style: AppTextStyles.bodySmallText,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const DashedDivider(),
                  const SizedBox(height: 16),
                  const Text(
                    'Data Anak',
                    style: AppTextStyles.sectionTitleText,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      NameAvatar(name: history.name),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              history.name,
                              style: AppTextStyles.bodyHiEmText,
                            ),
                            Text(
                              history.gender,
                              style: AppTextStyles.captionLowEmText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildRowFormattedInfo(
                    'Usia Anak',
                    '${history.ageInMonth} bulan',
                  ),
                  const SizedBox(height: 8),
                  _buildRowFormattedInfo(
                    'Tinggi Badan',
                    '${history.height} cm',
                  ),
                  const SizedBox(height: 8),
                  _buildRowFormattedInfo('Berat Badan', '${history.weight} kg'),
                  const SizedBox(height: 16),
                  const DashedDivider(),
                  const SizedBox(height: 16),
                  _buildStatusCard(history.nutritionalStatus),
                  const SizedBox(height: 12),
                  const Text(
                    '* Selamat! Tinggi badan anak Anda berada dalam batas normal sesuai usia',
                    style: AppTextStyles.bodySmallText,
                  ),
                  const SizedBox(height: 16),
                  const DashedDivider(),
                  const SizedBox(height: 16),
                  const Text(
                    'Detail Z-Score',
                    style: AppTextStyles.sectionTitleText,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Z-Score TB/U',
                    style: AppTextStyles.bodySmallLowEmText,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    history.zScore.toString(),
                    style: AppTextStyles.bodyText,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Kategori TB/U',
                    style: AppTextStyles.bodySmallLowEmText,
                  ),
                  const SizedBox(height: 8),
                  Text(history.zScoreCategory, style: AppTextStyles.bodyText),
                  const SizedBox(height: 16),
                  _buildZScoreGuidance(),
                  const SizedBox(height: 16),
                  const DashedDivider(),
                  const SizedBox(height: 16),
                  const Text(
                    'Rekomendasi Selanjutnya',
                    style: AppTextStyles.sectionTitleText,
                  ),
                  const SizedBox(height: 8),
                  history.recommendation == null
                      ? _buildGetRecommendation(provider)
                      : _buildShowRecommendation(),
                  history.isNewData
                      ? Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: CustomDefaultButton(
                            label: 'Simpan Hasil Analisa',
                            isLoading: provider.uiState is UiLoadingState,
                            onClick: () async {
                              await provider.saveAnalysis();
                            },
                          ),
                        )
                      : const SizedBox(),
                ],
              );
            },
          ),
        ),
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

  Widget _buildStatusCard(NutritionalStatus nutritionalStatus) {
    return CustomDefaultCard(
      backgroundColor: nutritionalStatus.color,
      content: Row(
        children: [
          const Icon(Icons.face, size: 36, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status TB/U',
                  style: AppTextStyles.captionText.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  nutritionalStatus.label,
                  style: AppTextStyles.bodyText.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZScoreGuidance() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline_rounded, size: 12),
              const SizedBox(width: 8),
              Text(
                'Tentang Z-Score',
                style: AppTextStyles.bodySmallLowEmText.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Z-Score merupakan nilai pembanding antara data anak Anda dengan data sehat anak sebaya.',
            style: AppTextStyles.bodySmallLowEmText,
          ),
          const SizedBox(height: 4),
          const Text(
            '~ Nilai 0 → Sesuai dengan rata-rata',
            style: AppTextStyles.bodySmallLowEmText,
          ),
          const SizedBox(height: 4),
          const Text(
            '~ Nilai -2 → Batas bahaya',
            style: AppTextStyles.bodySmallLowEmText,
          ),
        ],
      ),
    );
  }

  Widget _buildGetRecommendation(AnalysisResultProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dapatkan rekomendasi yang dipersonalisasi sesuai dengan hasil analisis dan usia anak Anda.',
          style: AppTextStyles.bodySmallText,
        ),
        const SizedBox(height: 4),
        const Text(
          '* Fitur ini membutuhkan koneksi internet',
          style: AppTextStyles.captionLowEmText,
        ),
        const SizedBox(height: 8),
        CustomCompactOutlinedButton(
          label: 'Dapatkan Rekomendasi',
          textStyle: AppTextStyles.bodySmallText,
          onClick: () async {
            _showProgressDialog(context);
            await provider.getRecommendation();
            if (mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }

  Widget _buildShowRecommendation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rekomendasi yang dipersonalisasi sesuai dengan hasil analisis dan usia anak Anda sudah berhasil didapatkan. Silahkan klik tombol di bawah untuk melihat',
          style: AppTextStyles.bodySmallText,
        ),
        const SizedBox(height: 8),
        CustomCompactOutlinedButton(
          label: 'Lihat Rekomendasi',
          textStyle: AppTextStyles.bodySmallText,
          onClick: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PersonalizedRecommendationPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
    context.read<AnalysisResultProvider>().resetState();
  }

  void _backToHomePage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (Route<dynamic> route) => false,
    );
  }

  void _showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ProgressDialog(message: 'Mengambil rekomendasi...');
      },
      barrierDismissible: false,
    );
  }
}
