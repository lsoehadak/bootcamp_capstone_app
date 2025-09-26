import 'package:flutter/foundation.dart';

class TipsService {
  Future<List<String>> fetchTips() async {
    // In a real app, this could fetch from a remote server or a local JSON file.
    // For this skeleton, we'll just return a hardcoded list.
    try {
      // Example of loading from a local JSON asset:
      // final String response = await rootBundle.loadString('assets/tips.json');
      // final List<dynamic> data = json.decode(response);
      // return data.map((tip) => tip.toString()).toList();
      await Future.delayed(
        const Duration(milliseconds: 500),
      ); // Simulate network delay
      return [
        "Pastikan anak mendapatkan ASI eksklusif selama 6 bulan pertama.",
        "Berikan makanan pendamping ASI (MP-ASI) yang kaya gizi setelah 6 bulan.",
        "Pantau berat dan tinggi badan anak secara teratur di Posyandu.",
        "Jaga kebersihan lingkungan dan sanitasi untuk mencegah penyakit.",
        "Lakukan imunisasi lengkap sesuai jadwal yang dianjurkan.",
        "Stimulasi perkembangan anak dengan bermain dan berinteraksi.",
      ];
    } catch (e) {
      debugPrint('Error fetching tips: $e');
      return [];
    }
  }
}
