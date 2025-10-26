import 'dart:async';

import 'package:capstone_app/services/auth_service.dart';
import 'package:capstone_app/services/firestore_service.dart';
import 'package:capstone_app/utils/ui_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/analysis_history.dart';
import '../utils/connection_utils.dart';

class HomeProvider extends ChangeNotifier {
  final FirestoreService _firestoreService;
  final AuthService _authService;

  late User? _user;

  User? get user => _user;

  HomeProvider(this._firestoreService, this._authService);

  UiState<List<AnalysisHistory>> _uiState = UiNoneState();

  UiState<List<AnalysisHistory>> get uiState => _uiState;

  Timer? _debounce;
  final Duration _debounceDuration = const Duration(milliseconds: 500);

  final _analysisHistoryList = <AnalysisHistory>[];
  final _filteredAnalysisHistoryList = <AnalysisHistory>[];

  List<AnalysisHistory> get filteredAnalysisHistoryList =>
      _filteredAnalysisHistoryList;

  void initUserData() {
    _user = _authService.currentUser;
  }

  Future<void> fetchAnalysisHistoryList() async {
    _uiState = UiLoadingState();
    notifyListeners();

    try {
      final analysisHistory = await _firestoreService.getAnalysisHistoryList(
        _authService.currentUser!.uid,
      );
      if (analysisHistory.isEmpty) {
        _uiState = UiEmptyState(
          'Belum Ada Riwayat Analisis',
          'Untuk mulai melakukan pengecekan dengan menekan tombol +. Riwayat analisis yang disimpan akan muncul di sini',
        );
      } else {
        _analysisHistoryList.clear();
        _analysisHistoryList.addAll(analysisHistory);
        _filterAnalysisHistoryList('');

        _uiState = UiSuccessState(_filteredAnalysisHistoryList);
      }
    } catch (e) {
      _uiState = UiErrorState('Terjadi Kesalahan', e.toString());
    } finally {
      notifyListeners();
    }
  }

  void searchAnalysisHistory(String keyword) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(_debounceDuration, () {
      _filterAnalysisHistoryList(keyword);
    });
  }

  void _filterAnalysisHistoryList(String keyword) {
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
        'Pastikan ejaan nama anak yang Anda masukkan benar, atau coba dengan nama anak lainnya',
      );
      notifyListeners();
    } else {
      _uiState = UiSuccessState(_filteredAnalysisHistoryList);
      notifyListeners();
    }
  }

  Future<bool> deleteAnalysisHistory(String analysisHistoryId) async {
    final isConnected = await checkInternetConnection();

    if (isConnected) {
      try {
        final result = await _firestoreService.deleteAnalysisHistory(
          _authService.currentUser!.uid,
          analysisHistoryId,
        );
        return result;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }
}
