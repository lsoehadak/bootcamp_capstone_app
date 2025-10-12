import 'package:capstone_app/data/dummy_analysis_history_data.dart';
import 'package:capstone_app/models/analysis_history.dart';
import 'package:capstone_app/services/api_service.dart';
import 'package:capstone_app/utils/ui_state.dart';
import 'package:flutter/material.dart';

class AnalysisResultProvider extends ChangeNotifier {
  final AnalysisHistory _analysisHistory;
  final ApiService _apiService;

  AnalysisHistory get analysisHistory => _analysisHistory;

  AnalysisResultProvider(this._analysisHistory, this._apiService);

  UiState<bool> _uiState = UiNoneState();

  UiState<bool> get uiState => _uiState;

  Future<bool> getRecommendation() async {
    notifyListeners();

    // simulate get recommendation from gemini
    await Future.delayed(const Duration(seconds: 2));

    _analysisHistory.recommendation = dummyRecommendationContent;

    notifyListeners();

    return true;
  }

  Future<void> saveAnalysis() async {
    _uiState = UiLoadingState();
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    try {
      final result = await _apiService.saveAnalysis(analysisHistory);
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
