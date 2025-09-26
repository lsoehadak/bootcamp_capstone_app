import 'dart:math';
import 'package:flutter/material.dart';

class TipsProvider with ChangeNotifier {
  final List<String> _tips = [
    "Pastikan anak mendapatkan ASI eksklusif selama 6 bulan pertama.",
    "Berikan makanan pendamping ASI (MP-ASI) yang kaya gizi setelah 6 bulan.",
    "Pantau berat dan tinggi badan anak secara teratur di Posyandu.",
    "Jaga kebersihan lingkungan dan sanitasi untuk mencegah penyakit.",
    "Lakukan imunisasi lengkap sesuai jadwal yang dianjurkan.",
    "Stimulasi perkembangan anak dengan bermain dan berinteraksi.",
  ];

  String get randomTip {
    final random = Random();
    return _tips[random.nextInt(_tips.length)];
  }

  // TODO: Jika ingin fetch tips dari service, implementasikan di sini
  Future<void> fetchTips() async {
    // Implementasi fetch tips jika diperlukan
  }
}
