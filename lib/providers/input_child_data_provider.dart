import 'dart:math';

import 'package:capstone_app/models/analysis_history.dart';
import 'package:capstone_app/services/tf_lite_service.dart';
import 'package:capstone_app/utils/ui_state.dart';
import 'package:flutter/material.dart';

import '../models/lms_data.dart';
import '../utils/lms_boy_constants.dart';
import '../utils/lms_girl_constants.dart';

class InputChildDataProvider extends ChangeNotifier {
  final TFLiteService _tfLiteService;

  InputChildDataProvider(this._tfLiteService);

  bool _isAgeInputValid = false;

  bool get isAgeInputValid => _isAgeInputValid;

  bool _isFormCompleted = false;

  bool get isFormCompleted => _isFormCompleted;

  int _selectedGender = 0;

  int get selectedGender => _selectedGender;

  UiState<AnalysisHistory> _uiState = UiNoneState();

  UiState<AnalysisHistory> get uiState => _uiState;

  void changeSelectedGender(int value) {
    _selectedGender = value;
    notifyListeners();
  }

  void changeIsAgeInputValid(bool value) {
    _isAgeInputValid = value;
    notifyListeners();
  }


  void changeFormCompletionStatus(bool status) {
    _isFormCompleted = status;
    notifyListeners();
  }

  void startAnalyze(String name, String ageInMonth, String height) async {
    _uiState = UiLoadingState();
    notifyListeners();

    try {
      final inferenceResult = await _tfLiteService.predict(
        ageIntMonth: int.parse(ageInMonth),
        gender: _selectedGender,
        height: double.parse(height),
      );

      final zScore = _calculateZScore(
        ageInMonth: int.parse(ageInMonth),
        gender: _selectedGender,
        height: double.parse(height),
      );

      final analysisHistory = AnalysisHistory(
        name: name,
        gender: _selectedGender == 0 ? 'Laki - Laki' : 'Perempuan',
        ageInMonth: int.parse(ageInMonth),
        height: double.parse(height),
        weight: 0,
        date: DateTime.now(),
        zScore: zScore,
        zScoreCategory: inferenceResult,
        recommendation: null,
        nutritionalStatus: inferenceResult.toNutritionalStatus(),
        isNewData: true,
      );

      _uiState = UiSuccessState(analysisHistory);
    } catch (e) {
      _uiState = UiErrorState('Terjadi Kesalahan', e.toString());
    } finally {
      notifyListeners();
    }
  }

  void resetState() {
    _uiState = UiNoneState();
    notifyListeners();
  }

  double _calculateZScore({required int ageInMonth, required int gender, required double height}) {
    final selectedLmsDataJson = gender == 0 ? lmsBoys : lmsGirls;
    final lmsData = selectedLmsDataJson.map((data) => LmsData.fromJson(data)).toList();

    final LmsData matchingLmsData = lmsData.firstWhere(
          (data) => data.month == ageInMonth,
    );

    final double L = matchingLmsData.l;
    final double M = matchingLmsData.m;
    final double S = matchingLmsData.s;

    double zScore;

    if (L != 0) {
      zScore = (pow(height / M, L) - 1) / (L * S);
    } else {
      zScore = log(height / M) / S;
    }

    return double.parse(zScore.toStringAsFixed(2));
  }
}
