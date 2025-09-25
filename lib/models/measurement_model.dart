class MeasurementModel {
  final String? id;
  final String childId;
  final DateTime date;
  final double weight;
  final double height;
  final double headCircumference;
  final String statusGizi; // e.g., 'Hijau', 'Kuning', 'Merah'

  MeasurementModel({
    this.id,
    required this.childId,
    required this.date,
    required this.weight,
    required this.height,
    required this.headCircumference,
    this.statusGizi = 'Hijau', // Default dummy value
  });

  factory MeasurementModel.fromMap(Map<String, dynamic> data, String documentId) {
    return MeasurementModel(
      id: documentId,
      childId: data['childId'] ?? '',
      date: (data['date']).toDate(),
      weight: (data['weight'] ?? 0.0).toDouble(),
      height: (data['height'] ?? 0.0).toDouble(),
      headCircumference: (data['headCircumference'] ?? 0.0).toDouble(),
      statusGizi: data['statusGizi'] ?? 'Hijau',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'childId': childId,
      'date': date,
      'weight': weight,
      'height': height,
      'headCircumference': headCircumference,
      'statusGizi': statusGizi,
    };
  }
}
