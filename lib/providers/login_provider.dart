import 'package:capstone_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../utils/ui_state.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService _authService;

  LoginProvider(this._authService);

  bool _isPasswordObscured = true;

  bool get isPasswordObscured => _isPasswordObscured;

  bool _isFormCompleted = false;

  bool get isFormCompleted => _isFormCompleted;

  UiState<bool> _uiState = UiNoneState();

  UiState<bool> get uiState => _uiState;

  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  void changeFormCompletionStatus(bool status) {
    _isFormCompleted = status;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _uiState = UiLoadingState();
    notifyListeners();

    try {
     await _authService.logIn(
        email: email,
        password: password,
      );

      _uiState = UiSuccessState(true);
    } catch (e) {
      _uiState = UiErrorState('Login Gagal', e.toString());
    } finally {
      notifyListeners();
    }
  }

  void resetState() {
    _uiState = UiNoneState();
    notifyListeners();
  }
}
