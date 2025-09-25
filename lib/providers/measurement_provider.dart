import 'package:flutter/material.dart';
import '../models/measurement_model.dart';

class MeasurementProvider with ChangeNotifier {
  final Map<String, List<MeasurementModel>> _measurements = {};
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<MeasurementModel> getMeasurementsForChild(String childId) {
    return _measurements[childId] ?? [];
  }

  Future<void> addMeasurement(MeasurementModel measurement) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Dummy delay

    if (!_measurements.containsKey(measurement.childId)) {
      _measurements[measurement.childId] = [];
    }
    _measurements[measurement.childId]!.add(measurement);
    _isLoading = false;
    notifyListeners();
  }

  // TODO: Fetch measurements from Firestore
}
