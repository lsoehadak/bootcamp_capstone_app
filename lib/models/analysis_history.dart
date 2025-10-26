import 'dart:ui';

import 'package:capstone_app/utils/app_colors.dart';

class AnalysisHistory {
  final String? id;
  final String name;
  final String gender;
  final int ageInMonth;
  final double height;
  final double weight;
  final DateTime date;
  final double zScore;
  final String zScoreCategory;
  final bool is3t;
  String? recommendation;
  final NutritionalStatus nutritionalStatus;
  final bool isNewData;

  AnalysisHistory({
    this.id,
    required this.name,
    required this.gender,
    required this.ageInMonth,
    required this.height,
    required this.weight,
    required this.date,
    required this.zScore,
    required this.zScoreCategory,
    required this.is3t,
    this.recommendation,
    required this.nutritionalStatus,
    this.isNewData = false,
  });

  factory AnalysisHistory.fromJson(Map<String, dynamic> json, String docId) {
    return AnalysisHistory(
      id: docId,
      name: json['name'] as String,
      gender: json['gender'] as String,
      ageInMonth: json['ageInMonth'] as int,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      zScore: json['zScore'] as double,
      zScoreCategory: json['zScoreCategory'] as String,
      is3t: json['is3t'] as bool,
      recommendation: json['recommendation'] as String?,
      nutritionalStatus: (json['nutritionalStatus'] as String)
          .toNutritionalStatus(),
      isNewData: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'ageInMonth': ageInMonth,
      'height': height,
      'weight': weight,
      'date': date.toIso8601String(),
      'zScore': zScore,
      'zScoreCategory': zScoreCategory,
      'is3t': is3t,
      'recommendation': recommendation,
      'nutritionalStatus': nutritionalStatus.label,
      'isNewData': isNewData,
    };
  }
}

enum NutritionalStatus {
  tall(
    'Tinggi',
    AppColors.greenStatusColor,
    '* Selamat! Tinggi badan anak Anda di atas batas normal untuk usianya.',
  ),
  normal(
    'Normal',
    AppColors.greenStatusColor,
    '* Selamat! Tinggi badan anak Anda berada dalam batas normal sesuai usia',
  ),
  stunted(
    'Pendek',
    AppColors.orangeStatusColor,
    '* Perhatian! Tinggi badan anak Anda tergolong pendek untuk usianya (stunting).',
  ),
  severeStunted(
    'Sangat Pendek',
    AppColors.redStatusColor,
    '* Peringatan! Tinggi badan anak Anda tergolong sangat pendek untuk usianya (stunting berat).',
  );

  const NutritionalStatus(this.label, this.color, this.summary);

  final String label;
  final Color color;
  final String summary;
}

extension NutritionalStatusParsing on String {
  NutritionalStatus toNutritionalStatus() {
    switch (this) {
      case 'Tinggi':
        return NutritionalStatus.tall;
      case 'Normal':
        return NutritionalStatus.normal;
      case 'Pendek':
        return NutritionalStatus.stunted;
      case 'Sangat Pendek':
        return NutritionalStatus.severeStunted;
      default:
        throw FormatException('Invalid nutritional status string: $this');
    }
  }
}
