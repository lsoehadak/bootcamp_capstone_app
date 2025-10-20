import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class ProfileProvider extends ChangeNotifier {
  final AuthService _authService;

  late User? _user;

  User? get user => _user;

  ProfileProvider(this._authService) {
    _user = _authService.currentUser;
  }

  Future<bool> logout() async {
    try {
      await _authService.logOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
