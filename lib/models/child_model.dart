class ChildModel {
  final String? id;
  final String nik;
  final String name;
  final int age; // in months
  final String gender; // 'Laki-laki' or 'Perempuan'
  final double weight; // in kg
  final double height; // in cm
  final double headCircumference; // in cm

  // Optional fields
  final String? birthHistory;
  final int? motherAgeAtBirth;
  final String? sanitation;

  const ChildModel({
    this.id,
    required this.nik,
    required this.name,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.headCircumference,
    this.birthHistory,
    this.motherAgeAtBirth,
    this.sanitation,
  });

  factory ChildModel.fromMap(Map<String, dynamic> data, String documentId) {
    double parseDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    int parseInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is num) return v.toInt();
      return int.tryParse(v.toString()) ?? 0;
    }

    return ChildModel(
      id: documentId,
      nik: (data['nik'] ?? '').toString(),
      name: (data['name'] ?? '').toString(),
      age: parseInt(data['age']),
      gender: (data['gender'] ?? '').toString(),
      weight: parseDouble(data['weight']),
      height: parseDouble(data['height']),
      headCircumference: parseDouble(data['headCircumference']),
      birthHistory: data['birthHistory']?.toString(),
      motherAgeAtBirth: data['motherAgeAtBirth'] is int
          ? data['motherAgeAtBirth'] as int
          : (data['motherAgeAtBirth'] is num
                ? (data['motherAgeAtBirth'] as num).toInt()
                : null),
      sanitation: data['sanitation']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nik': nik,
      'name': name,
      'age': age,
      'gender': gender,
      'weight': weight,
      'height': height,
      'headCircumference': headCircumference,
      if (birthHistory != null) 'birthHistory': birthHistory,
      if (motherAgeAtBirth != null) 'motherAgeAtBirth': motherAgeAtBirth,
      if (sanitation != null) 'sanitation': sanitation,
    };
  }
}
