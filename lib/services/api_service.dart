import 'package:capstone_app/models/analysis_history.dart';

import '../data/dummy_analysis_history_data.dart';

class ApiService {
  Future<List<AnalysisHistory>> fetchAnalysisHistoryList() {
    return Future.delayed(const Duration(seconds: 2), () {
      return listAnalysisHistory;
    });
  }
}