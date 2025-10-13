import 'package:flutter/material.dart';

import '../services/api_service.dart';

class RegisterProvider extends ChangeNotifier {
  final ApiService _apiService;

  RegisterProvider(this._apiService);

  bool _isPasswordObscured = true;

  bool get isPasswordObscured => _isPasswordObscured;

  bool _isConfirmPasswordObscured = true;

  bool get isConfirmPasswordObscured => _isConfirmPasswordObscured;

  bool _isFormCompleted = false;

  bool get isFormCompleted => _isFormCompleted;

  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
    notifyListeners();
  }

  void changeFormCompletionStatus(bool status) {
    _isFormCompleted = status;
    notifyListeners();
  }
}
