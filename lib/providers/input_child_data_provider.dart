import 'package:capstone_app/models/analysis_history.dart';
import 'package:capstone_app/utils/ui_state.dart';
import 'package:flutter/material.dart';

class InputChildDataProvider extends ChangeNotifier {
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

  void changeFormCompletionStatus(bool status) {
    _isFormCompleted = status;
    notifyListeners();
  }

  void startAnalyze(
    String name,
    String age,
    String weight,
    String height,
  ) async {
    _uiState = UiLoadingState();
    notifyListeners();

    // simulate inference process
    // return null if process failed and return result if process success
    await Future.delayed(const Duration(seconds: 1));
    final result = AnalysisHistory(
      id: '1',
      name: name,
      gender: _selectedGender == 0 ? 'Laki - Laki' : 'Perempuan',
      ageInMonth: int.parse(age),
      height: double.parse(height),
      weight: double.parse(weight),
      date: DateTime.now(),
      zScore: 0,
      zScoreCategory: 'Normal',
      recommendation: null,
      nutritionalStatus: NutritionalStatus.normal,
      isNewData: true,
    );

    _uiState = UiSuccessState(result);
    // _uiState = UiErrorState('Terjadi Kesalahan', 'Gagal melakukan analisa, silahkan coba kembali');
    notifyListeners();
  }

  void resetState() {
    _uiState = UiNoneState();
    notifyListeners();
  }
}
