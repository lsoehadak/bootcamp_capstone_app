import 'package:capstone_app/data/dummy_analysis_history_data.dart';
import 'package:capstone_app/models/analysis_history.dart';
import 'package:capstone_app/services/firestore_service.dart';
import 'package:capstone_app/utils/ui_state.dart';
import 'package:flutter/material.dart';

class AnalysisResultProvider extends ChangeNotifier {
  final AnalysisHistory _analysisHistory;
  final FirestoreService _firestoreService;

  AnalysisHistory get analysisHistory => _analysisHistory;

  String? _recommendation;

  String? get recommendation => _recommendation;

  AnalysisResultProvider(this._analysisHistory, this._firestoreService) {
    _recommendation = _analysisHistory.recommendation;
  }

  UiState<bool> _uiState = UiNoneState();

  UiState<bool> get uiState => _uiState;

  bool _isDataUpdated = false;

  bool get isDataUpdated => _isDataUpdated;

  Future<bool> getRecommendation() async {
    notifyListeners();

    // simulate get recommendation from gemini
    await Future.delayed(const Duration(seconds: 2));

    _isDataUpdated = true;

    // _analysisHistory.recommendation = dummyRecommendationContent;
    _recommendation = dummyRecommendationContent;

    notifyListeners();

    return true;
  }

  Future<void> saveAnalysis() async {
    _uiState = UiLoadingState();
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    try {
      analysisHistory.recommendation = _recommendation;
      final result = isDataUpdated
          ? await _firestoreService.updateAnalysisHistory(
              'UID123',
              analysisHistory,
            )
          : await _firestoreService.saveAnalysisHistory(
              'UID123',
              analysisHistory,
            );
      if (result) {
        _uiState = UiSuccessState(true);
      } else {
        _uiState = UiErrorState(
          'Terjadi Kesalahan',
          'Gagal menyimpan hasil analisis',
        );
      }
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
}
