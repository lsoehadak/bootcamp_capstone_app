import 'package:flutter/material.dart';
import '../models/user_model.dart';
// import '../services/auth_service.dart'; // Uncomment when service is ready

class AuthProvider with ChangeNotifier {
  // final AuthService _authService = AuthService(); // Uncomment when service is ready
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      // _user = await _authService.signInWithEmailAndPassword(email, password); // Real logic
      // For now, using dummy data
      await Future.delayed(const Duration(seconds: 1));
      _user = UserModel(uid: 'dummy-uid', name: 'Dummy User', email: email, role: 'parent');
    } catch (e) {
      // Handle error
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String name, String email, String password, String role) async {
    _isLoading = true;
    notifyListeners();
    try {
      // _user = await _authService.createUserWithEmailAndPassword(name, email, password, role); // Real logic
      await Future.delayed(const Duration(seconds: 1));
      _user = UserModel(uid: 'dummy-uid', name: name, email: email, role: role);
    } catch (e) {
      // Handle error
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    // await _authService.signOut(); // Real logic
    _user = null;
    notifyListeners();
  }
}
