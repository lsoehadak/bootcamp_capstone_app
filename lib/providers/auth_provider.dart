import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      // TODO: Ganti dengan logic AuthService
      await Future.delayed(const Duration(seconds: 1));
      _user = UserModel(
        uid: 'dummy-uid',
        name: 'Dummy User',
        email: email,
        role: 'parent',
      );
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      // TODO: Ganti dengan logic AuthService
      await Future.delayed(const Duration(seconds: 1));
      _user = UserModel(uid: 'dummy-uid', name: name, email: email, role: role);
    } catch (e) {
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
