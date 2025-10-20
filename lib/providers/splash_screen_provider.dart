import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class SplashScreenProvider extends ChangeNotifier {
  final AuthService _authService;

  SplashScreenProvider(this._authService);

  bool? _isUserLogIn;

  bool? get isUserLogin => _isUserLogIn;

  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    final user = _authService.currentUser;
    if (user != null) {
      _isUserLogIn = true;
    } else {
      _isUserLogIn = false;
    }

    notifyListeners();
  }
}
