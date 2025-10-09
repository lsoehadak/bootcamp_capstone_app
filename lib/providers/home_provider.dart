import 'package:capstone_app/services/api_service.dart';
import 'package:capstone_app/utils/ui_state.dart';
import 'package:flutter/material.dart';

import '../models/analysis_history.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService _apiService;

  HomeProvider(this._apiService);

  UiState<List<AnalysisHistory>> _uiState = UiNoneState();

  UiState<List<AnalysisHistory>> get uiState => _uiState;

  final _analysisHistoryList = <AnalysisHistory>[];
  final _filteredAnalysisHistoryList = <AnalysisHistory>[];

  List<AnalysisHistory> get filteredAnalysisHistoryList => _filteredAnalysisHistoryList;

  Future<void> fetchAnalysisHistoryList() async {
    _uiState = UiLoadingState();
    notifyListeners();

    try {
      final analysisHistory = await _apiService.fetchAnalysisHistoryList();
      if (analysisHistory.isEmpty) {
        _uiState = UiEmptyState(
          'Belum Ada Riwayat Analisa',
          'Untuk mulai melakukan pengecekan dengan menekan tombol +. Riwayat analisa yang disimpan akan muncul di sini',
        );
      } else {
        _analysisHistoryList.clear();
        _analysisHistoryList.addAll(analysisHistory);
        _filteredAnalysisHistoryList.addAll(_analysisHistoryList);

        _uiState = UiSuccessState(_filteredAnalysisHistoryList);
      }
    } catch (e) {
      _uiState = UiErrorState('Terjadi Kesalahan', e.toString());
    } finally {
      notifyListeners();
    }
  }

  void filterAnalysisHistoryList(String keyword) {
    _uiState = UiLoadingState<List<AnalysisHistory>>();
    notifyListeners();

    _filteredAnalysisHistoryList.clear();
    _filteredAnalysisHistoryList.addAll(
      _analysisHistoryList.where(
            (element) => element.name.toLowerCase().contains(keyword.toLowerCase()),
      ),
    );

    if (_filteredAnalysisHistoryList.isEmpty) {
      _uiState = UiEmptyState(
        'Nama Anak Tidak Ditemukan',
        'Pastikan kata kunci yang Anda masukkan benar, atau coba dengan kata kunci lainnya',
      );
      notifyListeners();
    } else {
      _uiState = UiSuccessState(_filteredAnalysisHistoryList);
      notifyListeners();
    }

    // print all _filteredAnalysisHistoryList
    for (var element in _filteredAnalysisHistoryList) {
      debugPrint(element.name);
    }
  }
}
