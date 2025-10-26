import 'package:capstone_app/models/analysis_history.dart';

class GenAiPrompt {
  static String getSystemInstruction() {
    return '''Sajikan semua dalam bentuk tag HTML sederhana (<h2>, <p>, <ul>, <li>) tanpa menggunakan tag tabel atau styling. 
    Jangan gunakan tag <hr>. 
    JANGAN gunakan blok kode Markdown seperti ``` atau indikator bahasa seperti ```html. 
    Berikan HANYA tag HTML.''';
  }

  static String getRecommendationPrompt(AnalysisHistory history) {
    return '''
    Saya akan memberikan data anak di bawah ini. Abaikan permintaan untuk menampilkan kembali data yang telah diinputkan.

Data Anak Input:

Jenis Kelamin: ${history.gender}

Tinggi Badan:  ${history.height} cm

Usia:  ${history.ageInMonth} Bulan

Kategori Status TB/U: ${history.zScoreCategory}

Instruksi Output:
- Berikan judul sebelum masuk ke poin rekomendasi, pastikan kalimat judulnya seperti ini. Rekomendasi untuk Anak dengan status TB/U ${history.zScoreCategory}:
- Setelah judul, langsung mulai tuliskan rekomendasi tanpa tambahan kalimat apapun sebelumnya
- Berikan rekomendasi aksi spesifik untuk orang tua berdasarkan Kategori Status TB/U yang diinputkan.
- Rekomendasi meliputi 3 aspek: Gizi/Nutrisi, Pemantauan, dan Pola Asuh.
- Untuk judul tiap aspek tidak perlu di beri tag <ul> 
- Instruksi Detail untuk Gizi/Nutrisi: Berikan rekomendasi yang sangat spesifik dan praktis, termasuk contoh makanan yang mudah didapatkan untuk memudahkan pengguna yang minim pengetahuan gizi.
- Batasan: Setiap aspek harus memiliki maksimal 3 poin.
- JANGAN berikan informasi atau tawaran informasi lain (seperti penawaran untuk mencari resep makanan, bertanya, atau melanjutkan percakapan) selain dari rekomendasi yang diminta (Output harus berakhir setelah rekomendasi terakhir). 
    ''';
  }

  static String get3TRecommendationPrompt(AnalysisHistory history) {
    return '''
    Saya akan memberikan data anak di bawah ini. Abaikan permintaan untuk menampilkan kembali data yang telah diinputkan.

Data Anak Input:

Jenis Kelamin: ${history.gender}

Tinggi Badan:  ${history.height} cm

Usia:  ${history.ageInMonth} Bulan

Kategori Status TB/U: ${history.zScoreCategory}

Instruksi Output:
- Berikan judul sebelum masuk ke poin rekomendasi, pastikan kalimat judulnya seperti ini. Rekomendasi untuk Anak dengan status TB/U ${history.zScoreCategory}:
- Setelah judul, langsung mulai tuliskan rekomendasi tanpa tambahan kalimat apapun sebelumnya
- Berikan rekomendasi aksi spesifik untuk orang tua berdasarkan Kategori Status TB/U yang diinputkan.
- Rekomendasi meliputi 3 aspek: Gizi/Nutrisi, Pemantauan, dan Pola Asuh.
- Untuk judul tiap aspek tidak perlu di beri tag <ul> 
- Instruksi Detail untuk Gizi/Nutrisi: Berikan rekomendasi yang sangat spesifik dan praktis, termasuk contoh makanan yang mudah didapatkan untuk memudahkan pengguna yang minim pengetahuan gizi dan pastikan rekomendasi relevan dengan penduduk daerah 3T (tertinggal, terdepan, terluar).
- Batasan: Setiap aspek harus memiliki maksimal 3 poin.
- JANGAN berikan informasi atau tawaran informasi lain (seperti penawaran untuk mencari resep makanan, bertanya, atau melanjutkan percakapan) selain dari rekomendasi yang diminta (Output harus berakhir setelah rekomendasi terakhir). 
    ''';
  }
}
