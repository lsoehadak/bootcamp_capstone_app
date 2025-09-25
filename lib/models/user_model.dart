class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role; // 'orang_tua' or 'kader_posyandu'

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
  });

  // Factory constructor to create a UserModel from a map (e.g., from Firestore)
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      uid: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'orang_tua',
    );
  }

  // Method to convert a UserModel to a map (e.g., for writing to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
    };
  }
}
