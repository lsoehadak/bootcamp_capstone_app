import 'dart:ui';

import 'package:capstone_app/utils/app_colors.dart';

class AnalysisHistory {
  final String id;
  final String name;
  final String gender;
  final int ageInMonth;
  final double height;
  final double weight;
  final DateTime date;
  final int zScore;
  final String zScoreCategory;
  String? recommendation;
  final NutritionalStatus nutritionalStatus;
  final bool isNewData;

  AnalysisHistory({
    required this.id,
    required this.name,
    required this.gender,
    required this.ageInMonth,
    required this.height,
    required this.weight,
    required this.date,
    required this.zScore,
    required this.zScoreCategory,
    required this.recommendation,
    required this.nutritionalStatus,
    this.isNewData = false,
  });

  factory AnalysisHistory.fromJson(Map<String, dynamic> json) {
    return AnalysisHistory(
      id: json['id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      ageInMonth: json['ageInMonth'] as int,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      zScore: json['zScore'] as int,
      zScoreCategory: json['zScoreCategory'] as String,
      recommendation: json['recommendation'] as String,
      nutritionalStatus: (json['nutritionalStatus'] as String)
          .toNutritionalStatus(),
      isNewData: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'ageInMonth': ageInMonth,
      'height': height,
      'weight': weight,
      'date': date.toIso8601String(),
      'zScore': zScore,
      'zScoreCategory': zScoreCategory,
      'recommendation': recommendation,
      'nutritionalStatus': nutritionalStatus.label,
      'isNewData': isNewData,
    };
  }
}

enum NutritionalStatus {
  normal('Normal', AppColors.greenStatusColor),
  atRisk('Waspada', AppColors.orangeStatusColor),
  stunting('Stunting', AppColors.redStatusColor);

  const NutritionalStatus(this.label, this.color);

  final String label;
  final Color color;
}

extension NutritionalStatusParsing on String {
  NutritionalStatus toNutritionalStatus() {
    switch (this) {
      case 'Normal':
        return NutritionalStatus.normal;
      case 'Waspada':
        return NutritionalStatus.atRisk;
      case 'Stunting':
        return NutritionalStatus.stunting;
      default:
        throw FormatException('Invalid nutritional status string: $this');
    }
  }
}
