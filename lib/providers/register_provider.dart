import 'package:capstone_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../utils/ui_state.dart';

class RegisterProvider extends ChangeNotifier {
  final AuthService _authService;

  RegisterProvider(this._authService);

  bool _isPasswordObscured = true;

  bool get isPasswordObscured => _isPasswordObscured;

  bool _isConfirmPasswordObscured = true;

  bool get isConfirmPasswordObscured => _isConfirmPasswordObscured;

  bool _isFormCompleted = false;

  bool get isFormCompleted => _isFormCompleted;

  UiState<bool> _uiState = UiNoneState();

  UiState<bool> get uiState => _uiState;

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

  Future<void> register(
    String email,
    String password,
    String displayName,
  ) async {
    _uiState = UiLoadingState();
    notifyListeners();

    try {
      await _authService.register(
        email: email,
        password: password,
        displayName: displayName,
      );

      await _authService.logOut();

      _uiState = UiSuccessState(true);
    } catch (e) {
      _uiState = UiErrorState('Terjadi Kesalahan', e.toString());
    } finally {
      notifyListeners();
    }
  }

  void resetState() {
    _uiState = UiNoneState();
    notifyListeners();
  }
}
