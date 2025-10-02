import 'package:flutter/foundation.dart';
import '../models/child_tracking_model.dart';

class ChildTrackingProvider with ChangeNotifier {
  // Static data untuk demo - dalam real app ini akan connect ke database
  final List<ChildTrackingModel> _trackingData = [
    // Sample data untuk testing
    ChildTrackingModel(
      id: '1',
      childNik: '1234567890123456',
      measurementDate: DateTime.now().subtract(const Duration(days: 30)),
      weight: 8.5,
      height: 68.0,
      headCircumference: 42.0,
      ageInMonths: 6,
      status: 'Normal',
      notes: 'Perkembangan baik',
    ),
    ChildTrackingModel(
      id: '2',
      childNik: '1234567890123456',
      measurementDate: DateTime.now().subtract(const Duration(days: 60)),
      weight: 7.8,
      height: 65.0,
      headCircumference: 41.0,
      ageInMonths: 5,
      status: 'Normal',
    ),
    ChildTrackingModel(
      id: '3',
      childNik: '9876543210987654',
      measurementDate: DateTime.now().subtract(const Duration(days: 15)),
      weight: 12.2,
      height: 85.0,
      headCircumference: 48.0,
      ageInMonths: 18,
      status: 'Normal',
      notes: 'Anak aktif dan sehat',
    ),
  ];

  List<ChildTrackingModel> get allTrackingData =>
      List.unmodifiable(_trackingData);

  // Get tracking data for specific child by NIK
  List<ChildTrackingModel> getTrackingByNik(String nik) {
    final data = _trackingData
        .where((tracking) => tracking.childNik == nik)
        .toList();

    // Sort by measurement date (newest first)
    data.sort((a, b) => b.measurementDate.compareTo(a.measurementDate));
    return data;
  }

  // Get latest tracking for specific child
  ChildTrackingModel? getLatestTrackingByNik(String nik) {
    final trackingList = getTrackingByNik(nik);
    return trackingList.isNotEmpty ? trackingList.first : null;
  }

  // Add new tracking data
  void addTracking(ChildTrackingModel tracking) {
    final newTracking = ChildTrackingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      childNik: tracking.childNik,
      measurementDate: tracking.measurementDate,
      weight: tracking.weight,
      height: tracking.height,
      headCircumference: tracking.headCircumference,
      ageInMonths: tracking.ageInMonths,
      status: tracking.status,
      notes: tracking.notes,
    );

    _trackingData.add(newTracking);
    notifyListeners();
  }

  // Update tracking data
  void updateTracking(String id, ChildTrackingModel updatedTracking) {
    final index = _trackingData.indexWhere((tracking) => tracking.id == id);
    if (index != -1) {
      _trackingData[index] = ChildTrackingModel(
        id: id,
        childNik: updatedTracking.childNik,
        measurementDate: updatedTracking.measurementDate,
        weight: updatedTracking.weight,
        height: updatedTracking.height,
        headCircumference: updatedTracking.headCircumference,
        ageInMonths: updatedTracking.ageInMonths,
        status: updatedTracking.status,
        notes: updatedTracking.notes,
      );
      notifyListeners();
    }
  }

  // Delete tracking data
  void deleteTracking(String id) {
    _trackingData.removeWhere((tracking) => tracking.id == id);
    notifyListeners();
  }

  // Get tracking statistics for a child
  Map<String, dynamic> getTrackingStats(String nik) {
    final trackingList = getTrackingByNik(nik);

    if (trackingList.isEmpty) {
      return {
        'totalRecords': 0,
        'latestStatus': 'Belum ada data',
        'normalCount': 0,
        'abnormalCount': 0,
      };
    }

    final normalCount = trackingList
        .where((t) => t.status.toLowerCase() == 'normal')
        .length;
    final abnormalCount = trackingList.length - normalCount;

    return {
      'totalRecords': trackingList.length,
      'latestStatus': trackingList.first.status,
      'normalCount': normalCount,
      'abnormalCount': abnormalCount,
    };
  }

  // Get growth trend (simplified)
  Map<String, String> getGrowthTrend(String nik) {
    final trackingList = getTrackingByNik(nik);

    if (trackingList.length < 2) {
      return {
        'weight': 'Perlu lebih banyak data',
        'height': 'Perlu lebih banyak data',
        'headCirc': 'Perlu lebih banyak data',
      };
    }

    final latest = trackingList[0];
    final previous = trackingList[1];

    return {
      'weight': latest.weight > previous.weight
          ? 'Naik'
          : latest.weight < previous.weight
          ? 'Turun'
          : 'Stabil',
      'height': latest.height > previous.height
          ? 'Naik'
          : latest.height < previous.height
          ? 'Turun'
          : 'Stabil',
      'headCirc': latest.headCircumference > previous.headCircumference
          ? 'Naik'
          : latest.headCircumference < previous.headCircumference
          ? 'Turun'
          : 'Stabil',
    };
  }
}
