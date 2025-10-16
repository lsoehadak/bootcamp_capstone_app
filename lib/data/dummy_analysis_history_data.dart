import '../models/analysis_history.dart';

final List<AnalysisHistory> listAnalysisHistory = [
  AnalysisHistory(
    id: 'AH001',
    name: 'Budi Santoso',
    gender: 'Laki-laki',
    ageInMonth: 24,
    height: 85.5,
    // cm
    weight: 12.0,
    // kg
    date: DateTime(2025, 10, 5),
    zScore: 1,
    zScoreCategory: 'Normal (Di atas -2 SD)',
    recommendation:
        'Pertahankan asupan gizi seimbang dan pantau pertumbuhan rutin.',
    nutritionalStatus: NutritionalStatus.normal,
  ),
  AnalysisHistory(
    id: 'AH002',
    name: 'Siti Aminah',
    gender: 'Perempuan',
    ageInMonth: 18,
    height: 75.0,
    // cm
    weight: 9.0,
    // kg
    date: DateTime(2025, 9, 28),
    zScore: -3,
    zScoreCategory: 'Sangat Pendek',
    recommendation:
        'Segera konsultasi ke dokter spesialis anak atau ahli gizi untuk intervensi stunting intensif.',
    nutritionalStatus: NutritionalStatus.severeStunted,
  ),
  AnalysisHistory(
    id: 'AH003',
    name: 'Joko Prabowo',
    gender: 'Laki-laki',
    ageInMonth: 6,
    height: 65.0,
    // cm
    weight: 7.5,
    // kg
    date: DateTime(2025, 10, 1),
    zScore: -2,
    zScoreCategory: 'Waspada',
    recommendation:
        'Tingkatkan kualitas MPASI dan frekuensi pemberian makan. Perlu evaluasi gizi lebih lanjut.',
    nutritionalStatus: NutritionalStatus.stunted,
  ),
  AnalysisHistory(
    id: 'AH004',
    name: 'Dewi Lestari',
    gender: 'Perempuan',
    ageInMonth: 36,
    height: 98.0,
    // cm
    weight: 15.5,
    // kg
    date: DateTime(2025, 8, 15),
    zScore: 0,
    zScoreCategory: 'Normal',
    recommendation:
        'Lanjutkan gaya hidup sehat dan jangan lewatkan jadwal Posyandu.',
    nutritionalStatus: NutritionalStatus.normal,
  ),
];

const String dummyRecommendationContent = '''
Wah, hasil pengukuran status gizi menunjukkan Budi Darmawan tergolong Sangat Pendek. Tetap semangat ya, Bapak/Ibu! Ini adalah kesempatan untuk memberikan perhatian dan intervensi lebih lanjut agar pertumbuhan Budi bisa optimal.
<h2>Rekomendasi Aksi Spesifik untuk Status TB/U: Sangat Pendek</h2>
<h3>Gizi/Nutrisi</h3>
<ul>
<li>Fokus pada asupan protein hewani tinggi (minimal 2-3 kali sehari) seperti telur, hati ayam, ikan kembung, daging sapi, dan susu. Protein sangat penting untuk pertumbuhan.</li>
<li>Pastikan Budi mengonsumsi makanan lengkap dan beragam yang mengandung karbohidrat, protein, lemak, vitamin, dan mineral. Berikan makanan utama 3 kali sehari dan selingan (snack) bernutrisi 2 kali sehari.</li>
<li>Berikan suplemen vitamin dan mineral yang dianjurkan oleh tenaga kesehatan (seperti Vitamin A, Zinc, atau zat besi) sesuai dosis, setelah berkonsultasi dengan dokter atau ahli gizi.</li>
</ul>
<h3>Pemantauan</h3>
<ul>
<li>Lakukan pengukuran tinggi badan dan berat badan secara rutin (minimal sebulan sekali) di Posyandu atau fasilitas kesehatan untuk memantau tren pertumbuhannya.</li>
<li>Segera konsultasikan hasil pengukuran ini dengan dokter spesialis anak atau ahli gizi untuk mendapatkan pemeriksaan kesehatan menyeluruh dan rencana intervensi gizi yang lebih terperinci dan personal.</li>
<li>Pastikan Budi mendapatkan imunisasi lengkap sesuai jadwal untuk mencegah infeksi penyakit yang dapat menghambat pertumbuhan.</li>
</ul>
<h3>Pola Asuh</h3>
<ul>
<li>Ciptakan lingkungan makan yang menyenangkan dan bebas paksaan. Ajak Budi makan bersama keluarga di meja makan dan biarkan ia memilih porsi makanannya sendiri (sesuai porsi anak).</li>
<li>Pastikan Budi mendapatkan waktu tidur yang cukup dan berkualitas (sekitar 10-13 jam per hari untuk usia 4 tahun) karena hormon pertumbuhan bekerja maksimal saat tidur.</li>
<li>Ajak Budi untuk aktif bergerak dan bermain di luar ruangan setiap hari untuk merangsang nafsu makan dan pertumbuhan tulangnya.</li>
</ul>''';
