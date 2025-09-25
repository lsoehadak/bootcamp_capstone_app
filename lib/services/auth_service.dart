import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'firestore_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        return await _firestoreService.getUser(user.uid);
      }
      return null;
    } catch (e) {
      // Handle exceptions
      print(e.toString());
      return null;
    }
  }

  Future<UserModel?> createUserWithEmailAndPassword(String name, String email, String password, String role) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        UserModel newUser = UserModel(uid: user.uid, name: name, email: email, role: role);
        await _firestoreService.createUser(newUser);
        return newUser;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
