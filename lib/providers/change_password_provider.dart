import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/ui_state.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final AuthService _authService;

  ChangePasswordProvider(this._authService);

  UiState<bool> _uiState = UiNoneState();

  UiState<bool> get uiState => _uiState;

  bool _isOldPasswordObscured = true;

  bool get isOldPasswordObscured => _isOldPasswordObscured;

  bool _isConfirmPasswordObscured = true;

  bool get isConfirmPasswordObscured => _isConfirmPasswordObscured;

  bool _isNewPasswordObscured = true;

  bool get isNewPasswordObscured => _isNewPasswordObscured;

  bool _isFormCompleted = false;

  bool get isFormCompleted => _isFormCompleted;

  void resetState() {
    _uiState = UiNoneState();
    notifyListeners();
  }

  void toggleOldPasswordVisibility() {
    _isOldPasswordObscured = !_isOldPasswordObscured;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _isNewPasswordObscured = !_isNewPasswordObscured;
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

  Future<void> changePassword(String oldPassword, String newPassword) async {
    _uiState = UiLoadingState();
    notifyListeners();
    try {
      final result = await _authService.changePassword(
        oldPassword,
        newPassword,
      );
      if (result) {
        _uiState = UiSuccessState(true);
      } else {
        _uiState = UiErrorState(
          'Terjadi Kesalahan',
          'Gagal mengubah password',
        );
      }
    } catch (e) {
      _uiState = UiErrorState('Terjadi Kesalahan', e.toString());
    } finally {
      notifyListeners();
    }
  }
}
