import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _user;
  bool _isLoading = false;

  AuthProvider() {
    // Listen to FirebaseAuth state changes
    _auth.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser != null) {
        _user = UserModel(
          uid: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          role: 'parent',
        );
        // Optionally persist a flag locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_logged_in', true);
      } else {
        _user = null;
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('is_logged_in');
      }
      notifyListeners();
    });
  }

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseUser = credential.user;
      if (firebaseUser != null) {
        _user = UserModel(
          uid: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          role: 'parent',
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_logged_in', true);
      }
    } on FirebaseAuthException {
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
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseUser = credential.user;
      if (firebaseUser != null) {
        await firebaseUser.updateDisplayName(name);
        _user = UserModel(
          uid: firebaseUser.uid,
          name: name,
          email: firebaseUser.email ?? '',
          role: role,
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('is_logged_in', true);
      }
    } on FirebaseAuthException {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_logged_in');
    notifyListeners();
  }
}
