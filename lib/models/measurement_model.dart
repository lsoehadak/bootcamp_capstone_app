class MeasurementModel {
  final String? id;
  final String childId;
  final DateTime date;
  final double weight;
  final double height;
  final double headCircumference;
  final String statusGizi; // e.g., 'Hijau', 'Kuning', 'Merah'

  const MeasurementModel({
    this.id,
    required this.childId,
    required this.date,
    required this.weight,
    required this.height,
    required this.headCircumference,
    this.statusGizi = 'Hijau',
  });

  factory MeasurementModel.fromMap(
    Map<String, dynamic> data,
    String documentId,
  ) {
    dynamic rawDate = data['date'];
    DateTime parsedDate;
    try {
      // Firestore Timestamp has toDate(), otherwise handle string/int
      if (rawDate == null) {
        parsedDate = DateTime.now();
      } else if (rawDate is DateTime) {
        parsedDate = rawDate;
      } else if (rawDate is Map && rawDate['_seconds'] != null) {
        // Serialized timestamp map
        parsedDate = DateTime.fromMillisecondsSinceEpoch(
          (rawDate['_seconds'] as int) * 1000,
        );
      } else if (rawDate is int) {
        parsedDate = DateTime.fromMillisecondsSinceEpoch(rawDate);
      } else {
        parsedDate = DateTime.tryParse(rawDate.toString()) ?? DateTime.now();
      }
    } catch (_) {
      parsedDate = DateTime.now();
    }

    double parseDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    return MeasurementModel(
      id: documentId,
      childId: (data['childId'] ?? '').toString(),
      date: parsedDate,
      weight: parseDouble(data['weight']),
      height: parseDouble(data['height']),
      headCircumference: parseDouble(data['headCircumference']),
      statusGizi: (data['statusGizi'] ?? 'Hijau').toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'childId': childId,
      // When writing to Firestore, it's fine to pass DateTime — the plugin handles conversion
      'date': date,
      'weight': weight,
      'height': height,
      'headCircumference': headCircumference,
      'statusGizi': statusGizi,
    };
  }
}
