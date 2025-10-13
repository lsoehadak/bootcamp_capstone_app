import 'package:flutter/material.dart';

import '../services/api_service.dart';

class LoginProvider extends ChangeNotifier {
  final ApiService _apiService;

  LoginProvider(this._apiService);

  bool _isPasswordObscured = true;

  bool get isPasswordObscured => _isPasswordObscured;

  bool _isFormCompleted = false;

  bool get isFormCompleted => _isFormCompleted;

  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  void changeFormCompletionStatus(bool status) {
    _isFormCompleted = status;
    notifyListeners();
  }

  void login() async {

  }
}
