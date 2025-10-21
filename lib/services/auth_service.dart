import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(displayName);
      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage =
              'Email ini sudah terdaftar. Silahkan gunakan email lain.';
          break;
        case 'invalid-email':
          errorMessage = 'Format email tidak valid. Mohon periksa kembali.';
          break;
        case 'network-request-failed':
          errorMessage =
              'Terjadi masalah koneksi. Mohon periksa koneksi internet Anda dan coba lagi.';
          break;
        default:
          errorMessage = 'Terjadi error yang tidak diketahui: ${e.message}';
          break;
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> logIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'invalid-credential':
          errorMessage =
              'Silahkan cek kembali email atau password Anda dan coba lagi.';
          break;
        case 'invalid-email':
          errorMessage = 'Format email tidak valid. Mohon periksa kembali.';
          break;
        case 'network-request-failed':
          errorMessage =
              'Terjadi masalah koneksi. Mohon periksa koneksi internet Anda dan coba lagi.';
          break;
        default:
          errorMessage = 'Terjadi error yang tidak diketahui: ${e.message}';
          break;
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> logOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  User? get currentUser {
    return _auth.currentUser;
  }
}
