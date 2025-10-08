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
    nutritionalStatus: NutritionalStatus.stunting,
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
    nutritionalStatus: NutritionalStatus.atRisk,
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

const dummyRecommendationContent = '''
Berikut adalah tiga tindakan nutrisi spesifik yang harus segera Bapak/Ibu terapkan:

Tingkatkan Asupan Protein Hewani Setiap Hari: Pastikan Budi mengonsumsi minimal 2-3 porsi protein hewani per hari (diutamakan sumber HEME​ yang mudah diserap). Sumber terbaik meliputi telur (1 butir penuh), hati ayam, daging merah, atau ikan (misalnya, ikan kembung/salmon). Protein hewani adalah "bahan bakar" utama untuk pertumbuhan tulang dan tinggi badan.

Perkaya Makanan dengan Lemak Sehat dan Mikronutrien Penting: Dalam setiap porsi makan utama, tambahkan sumber lemak sehat seperti santan kental, minyak zaitun, atau margarin/mentega untuk meningkatkan kepadatan energi tanpa menambah volume terlalu banyak. Selain itu, berikan makanan yang kaya Zat Besi, Seng (Zinc), dan Kalsium (misalnya dari daging, seafood, sayuran hijau gelap, dan produk susu) karena mikronutrien ini esensial untuk pembentukan tulang dan fungsi imun.

Jadwal Makan Terstruktur (Tiga Kali Makanan Utama dan Dua Kali Makanan Selingan): Terapkan jadwal makan yang teratur untuk memastikan asupan energi dan zat gizi makro-mikro terpenuhi. Berikan tiga kali makanan utama (lengkap: karbohidrat, protein hewani, sayur, lemak) dan dua kali makanan selingan (snack) yang padat gizi (misalnya, puding susu, buah alpukat, atau smoothie). Hindari memberikan terlalu banyak minuman manis atau makanan ringan (snack) yang bernilai gizi rendah menjelang waktu makan, karena dapat mengurangi nafsu makan Budi terhadap makanan utama.
''';
