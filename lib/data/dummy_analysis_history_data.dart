import '../models/analysis_history.dart';

var listAnalysisHistory = [
  AnalysisHistory(
    id: 'H-001',
    name: 'Budi Santoso',
    gender: 'Laki-laki',
    ageInMonth: 18,
    // 1 tahun 6 bulan
    height: 78.5,
    // cm
    weight: 10.8,
    // kg
    date: DateTime(2025, 10, 5),
    nutritionalStatus: NutritionalStatus.normal,
  ),

  AnalysisHistory(
    id: 'H-002',
    name: 'Siti Aisyah',
    gender: 'Perempuan',
    ageInMonth: 30,
    // 2 tahun 6 bulan
    height: 80.0,
    // cm (Rendah)
    weight: 12.0,
    // kg
    date: DateTime(2025, 9, 28),
    nutritionalStatus: NutritionalStatus.stunting, // Stunting
  ),

  AnalysisHistory(
    id: 'H-003',
    name: 'Joko Prabowo',
    gender: 'Laki-laki',
    ageInMonth: 6,
    // 6 bulan
    height: 67.0,
    // cm
    weight: 7.2,
    // kg (Hampir normal, tapi waspada)
    date: DateTime(2025, 10, 1),
    nutritionalStatus: NutritionalStatus.atRisk, // Waspada
  ),
];
