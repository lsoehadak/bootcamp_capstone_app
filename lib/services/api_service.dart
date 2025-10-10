import 'package:capstone_app/models/analysis_history.dart';

import '../data/dummy_analysis_history_data.dart';

class ApiService {
  Future<List<AnalysisHistory>> fetchAnalysisHistoryList() {
    return Future.delayed(const Duration(seconds: 1), () {
      return listAnalysisHistory;
    });
  }

  Future<bool> saveAnalysis(AnalysisHistory analysisHistory) {
    return Future.delayed(const Duration(seconds: 1), () {
      return true;
    });
  }
}