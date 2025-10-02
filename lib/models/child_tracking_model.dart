import 'package:flutter/material.dart';

class ChildTrackingModel {
  final String? id;
  final String childNik;
  final DateTime measurementDate;
  final double weight; // kg
  final double height; // cm
  final double headCircumference; // cm
  final int ageInMonths;
  final String status; // 'Normal', 'Stunting', 'Wasting', 'Underweight', dll
  final String? notes;

  const ChildTrackingModel({
    this.id,
    required this.childNik,
    required this.measurementDate,
    required this.weight,
    required this.height,
    required this.headCircumference,
    required this.ageInMonths,
    required this.status,
    this.notes,
  });

  factory ChildTrackingModel.fromMap(
    Map<String, dynamic> data,
    String documentId,
  ) {
    double parseDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    int parseInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is num) return v.toInt();
      return int.tryParse(v.toString()) ?? 0;
    }

    DateTime parseDate(dynamic v) {
      if (v == null) return DateTime.now();
      if (v is DateTime) return v;
      return DateTime.tryParse(v.toString()) ?? DateTime.now();
    }

    return ChildTrackingModel(
      id: documentId,
      childNik: (data['childNik'] ?? '').toString(),
      measurementDate: parseDate(data['measurementDate']),
      weight: parseDouble(data['weight']),
      height: parseDouble(data['height']),
      headCircumference: parseDouble(data['headCircumference']),
      ageInMonths: parseInt(data['ageInMonths']),
      status: (data['status'] ?? '').toString(),
      notes: data['notes']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'childNik': childNik,
      'measurementDate': measurementDate.toIso8601String(),
      'weight': weight,
      'height': height,
      'headCircumference': headCircumference,
      'ageInMonths': ageInMonths,
      'status': status,
      if (notes != null) 'notes': notes,
    };
  }

  // Calculate Z-scores and status
  static String calculateStatus(
    double weight,
    double height,
    double headCirc,
    int ageInMonths,
    String gender,
  ) {
    // Simplified status calculation - in real app would use WHO growth standards
    List<String> issues = [];

    // Basic checks (these would be replaced with proper WHO z-score calculations)
    if (ageInMonths >= 24) {
      // For children 2+ years
      // Height for age (stunting check)
      double expectedHeight = gender == 'Laki-laki'
          ? (75 + (ageInMonths - 12) * 1.2)
          : // Simplified formula
            (74 + (ageInMonths - 12) * 1.1);

      if (height < expectedHeight * 0.9) {
        issues.add('Stunting');
      }

      // Weight for height (wasting check)
      double expectedWeight = (height - 100) * 0.9; // Very simplified
      if (weight < expectedWeight * 0.85) {
        issues.add('Wasting');
      }
    } else {
      // For children under 2 years
      // Very basic checks for infants
      double minWeight = ageInMonths * 0.5 + 3; // Simplified
      double minHeight = ageInMonths * 2 + 50; // Simplified

      if (weight < minWeight) {
        issues.add('Underweight');
      }
      if (height < minHeight) {
        issues.add('Pendek');
      }
    }

    if (issues.isEmpty) {
      return 'Normal';
    } else if (issues.length == 1) {
      return issues.first;
    } else {
      return issues.join(' & ');
    }
  }

  // Get status color
  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case 'normal':
        return const Color(0xFF4CAF50); // Green
      case 'stunting':
      case 'pendek':
        return const Color(0xFFFF9800); // Orange
      case 'wasting':
      case 'underweight':
        return const Color(0xFFF44336); // Red
      default:
        return const Color(0xFF9E9E9E); // Grey
    }
  }

  // Get status icon
  IconData getStatusIcon() {
    switch (status.toLowerCase()) {
      case 'normal':
        return Icons.check_circle;
      case 'stunting':
      case 'pendek':
        return Icons.warning;
      case 'wasting':
      case 'underweight':
        return Icons.error;
      default:
        return Icons.help;
    }
  }
}
