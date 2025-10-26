import 'package:capstone_app/models/analysis_history.dart';
import 'package:capstone_app/services/auth_service.dart';
import 'package:capstone_app/services/firestore_service.dart';
import 'package:capstone_app/utils/connection_utils.dart';
import 'package:capstone_app/utils/gen_ai_prompt.dart';
import 'package:capstone_app/utils/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../env/env.dart';

class AnalysisResultProvider extends ChangeNotifier {
  final FirestoreService _firestoreService;
  final AuthService _authService;

  final AnalysisHistory _analysisHistory;

  AnalysisHistory get analysisHistory => _analysisHistory;

  String? _recommendation;

  String? get recommendation => _recommendation;

  AnalysisResultProvider(
    this._analysisHistory,
    this._firestoreService,
    this._authService,
  ) {
    _recommendation = _analysisHistory.recommendation;
  }

  UiState<bool> _uiState = UiNoneState();

  UiState<bool> get uiState => _uiState;

  bool _isDataUpdated = false;

  bool get isDataUpdated => _isDataUpdated;

  Future<bool> getRecommendation() async {
    notifyListeners();

    GenerativeModel model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: Env.geminiApiKey,
      systemInstruction: Content.system(GenAiPrompt.getSystemInstruction()),
    );

    final prompt = _analysisHistory.is3t
        ? GenAiPrompt.get3TRecommendationPrompt(_analysisHistory)
        : GenAiPrompt.getRecommendationPrompt(_analysisHistory);

    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      _recommendation = response.text.toString();
      _isDataUpdated = true;
      notifyListeners();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> saveAnalysis() async {
    _uiState = UiLoadingState();
    notifyListeners();

    final isConnected = await checkInternetConnection();

    if (isConnected) {
      try {
        analysisHistory.recommendation = _recommendation;
        final result = isDataUpdated && !analysisHistory.isNewData
            ? await _firestoreService.updateAnalysisHistory(
                _authService.currentUser!.uid,
                analysisHistory,
              )
            : await _firestoreService.saveAnalysisHistory(
                _authService.currentUser!.uid,
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
    } else {
      _uiState = UiErrorState(
        'Tidak ada koneksi internet',
        'Silahkan coba lagi dan pastikan perangkat terhubung dengan internet',
      );
      notifyListeners();
    }
  }

  void resetState() {
    _uiState = UiNoneState();
    notifyListeners();
  }
}
