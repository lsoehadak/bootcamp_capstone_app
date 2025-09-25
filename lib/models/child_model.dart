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

  ChildModel({
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
    return ChildModel(
      id: documentId,
      nik: data['nik'] ?? '',
      name: data['name'] ?? '',
      age: data['age'] ?? 0,
      gender: data['gender'] ?? '',
      weight: (data['weight'] ?? 0.0).toDouble(),
      height: (data['height'] ?? 0.0).toDouble(),
      headCircumference: (data['headCircumference'] ?? 0.0).toDouble(),
      birthHistory: data['birthHistory'],
      motherAgeAtBirth: data['motherAgeAtBirth'],
      sanitation: data['sanitation'],
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
      'birthHistory': birthHistory,
      'motherAgeAtBirth': motherAgeAtBirth,
      'sanitation': sanitation,
    };
  }
}
