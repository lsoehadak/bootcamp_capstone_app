import 'package:capstone_app/screens/common/widgets/custom_button.dart';
import 'package:capstone_app/screens/common/widgets/custom_card.dart';
import 'package:capstone_app/screens/common/widgets/custom_divider.dart';
import 'package:capstone_app/screens/home/home_page.dart';
import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Analisa')),
      body: SafeArea(
        top: false,
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tanggal Analisa', style: AppTextStyles.bodySmallText),
                  Text('8 Juni 2025', style: AppTextStyles.bodySmallText),
                ],
              ),
              const SizedBox(height: 16),
              const DashedDivider(),
              const SizedBox(height: 16),
              const Text('Data Anak', style: AppTextStyles.sectionTitleText),
              const SizedBox(height: 16),
              const Row(
                children: [
                  NameAvatar(name: 'Budi Darmawan'),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Budi Darmawan',
                          style: AppTextStyles.bodyHiEmText,
                        ),
                        Text(
                          'Laki - Laki',
                          style: AppTextStyles.captionLowEmText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildRowFormattedInfo('Usia Anak', '8 bulan'),
              const SizedBox(height: 8),
              _buildRowFormattedInfo('Tinggi Badan', '50 cm'),
              const SizedBox(height: 8),
              _buildRowFormattedInfo('Berat Badan', '7.2 kg'),
              const SizedBox(height: 16),
              const DashedDivider(),
              const SizedBox(height: 16),
              _buildStatusCard(),
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
              const Text('0', style: AppTextStyles.bodyText),
              const SizedBox(height: 16),
              const Text(
                'Kategori TB/U',
                style: AppTextStyles.bodySmallLowEmText,
              ),
              const SizedBox(height: 8),
              const Text('Normal', style: AppTextStyles.bodyText),
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
              // _buildGetRecommendation(),
              _buildShowRecommendation(),
              const SizedBox(height: 24),
              CustomDefaultButton(
                label: 'Simpan Hasil Analisa',
                onClick: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
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

  Widget _buildStatusCard() {
    return CustomDefaultCard(
      backgroundColor: AppColors.greenStatusColor,
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
                  'Normal',
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

  Widget _buildGetRecommendation() {
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
          onClick: () {},
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
}
