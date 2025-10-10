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

  Future<void> getRecommendation() async {
    notifyListeners();

    // simulate get recommendation from gemini
    await Future.delayed(const Duration(seconds: 2));

    _analysisHistory.recommendation = '''
    Berikut adalah tiga tindakan nutrisi spesifik yang harus segera Bapak/Ibu terapkan:

Tingkatkan Asupan Protein Hewani Setiap Hari: Pastikan Budi mengonsumsi minimal 2-3 porsi protein hewani per hari (diutamakan sumber HEME​ yang mudah diserap). Sumber terbaik meliputi telur (1 butir penuh), hati ayam, daging merah, atau ikan (misalnya, ikan kembung/salmon). Protein hewani adalah "bahan bakar" utama untuk pertumbuhan tulang dan tinggi badan.

Perkaya Makanan dengan Lemak Sehat dan Mikronutrien Penting: Dalam setiap porsi makan utama, tambahkan sumber lemak sehat seperti santan kental, minyak zaitun, atau margarin/mentega untuk meningkatkan kepadatan energi tanpa menambah volume terlalu banyak. Selain itu, berikan makanan yang kaya Zat Besi, Seng (Zinc), dan Kalsium (misalnya dari daging, seafood, sayuran hijau gelap, dan produk susu) karena mikronutrien ini esensial untuk pembentukan tulang dan fungsi imun.

Jadwal Makan Terstruktur (Tiga Kali Makanan Utama dan Dua Kali Makanan Selingan): Terapkan jadwal makan yang teratur untuk memastikan asupan energi dan zat gizi makro-mikro terpenuhi. Berikan tiga kali makanan utama (lengkap: karbohidrat, protein hewani, sayur, lemak) dan dua kali makanan selingan (snack) yang padat gizi (misalnya, puding susu, buah alpukat, atau smoothie). Hindari memberikan terlalu banyak minuman manis atau makanan ringan (snack) yang bernilai gizi rendah menjelang waktu makan, karena dapat mengurangi nafsu makan Budi terhadap makanan utama.
    ''';

    notifyListeners();
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
