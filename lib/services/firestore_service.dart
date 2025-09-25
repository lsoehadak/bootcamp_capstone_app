import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/child_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Future<void> addChild(String userId, ChildModel child) async {
    await _db.collection('users').doc(userId).collection('children').add(child.toMap());
  }

  Stream<List<ChildModel>> getChildren(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('children')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChildModel.fromMap(doc.data(), doc.id))
            .toList());
  }
  
  // TODO: Add methods for measurements
}
