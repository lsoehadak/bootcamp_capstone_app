import 'package:capstone_app/providers/change_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_text_styles.dart';
import '../../utils/ui_state.dart';
import '../common/widgets/custom_button.dart';
import '../common/widgets/custom_snackbar.dart';
import '../common/widgets/custom_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resultState = context.watch<ChangePasswordProvider>().uiState;

    if (resultState is UiErrorState<bool>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorMessage(resultState.errorTitle, resultState.errorMessage);
        context.read<ChangePasswordProvider>().resetState();
      });
    } else if (resultState is UiSuccessState<bool>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context, true);
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Ubah Password')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<ChangePasswordProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Password Lama', style: AppTextStyles.labelText),
                const SizedBox(height: 8),
                CustomPasswordTextField(
                  controller: _oldPasswordController,
                  isObscure: provider.isOldPasswordObscured,
                  hint: 'Masukkan Password',
                  onReveal: () {
                    provider.toggleOldPasswordVisibility();
                  },
                  onChanged: (value) {
                    provider.changeFormCompletionStatus(
                      _checkAllFieldsFilled(),
                    );
                  },
                ),
                const SizedBox(height: 16),
                const Text('Password Baru', style: AppTextStyles.labelText),
                const SizedBox(height: 4),
                const Text('* Password minimal 6 karakter', style: AppTextStyles.captionLowEmText,),
                const SizedBox(height: 8),
                CustomPasswordTextField(
                  controller: _newPasswordController,
                  isObscure: provider.isNewPasswordObscured,
                  hint: 'Masukkan Password',
                  onReveal: () {
                    provider.toggleNewPasswordVisibility();
                  },
                  onChanged: (value) {
                    provider.changeFormCompletionStatus(
                      _checkAllFieldsFilled(),
                    );
                  },
                ),
                const SizedBox(height: 16),
                const Text('Konfirmasi Password Baru', style: AppTextStyles.labelText),
                const SizedBox(height: 8),
                CustomPasswordTextField(
                  controller: _confirmPasswordController,
                  isObscure: provider.isConfirmPasswordObscured,
                  hint: 'Masukkan Password',
                  onReveal: () {
                    provider.toggleConfirmPasswordVisibility();
                  },
                  onChanged: (value) {
                    provider.changeFormCompletionStatus(
                      _checkAllFieldsFilled(),
                    );
                  },
                ),
                const SizedBox(height: 32),
                CustomDefaultButton(
                  label: 'Ubah',
                  isEnabled: provider.isFormCompleted,
                  isLoading: provider.uiState is UiLoadingState,
                  onClick: () {
                    provider.changePassword(
                      _oldPasswordController.text,
                      _newPasswordController.text,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  bool _checkAllFieldsFilled() {
    return _oldPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _newPasswordController.text.length >= 6 &&
        _confirmPasswordController.text.isNotEmpty &&
        _newPasswordController.text == _confirmPasswordController.text;
  }

  void _showErrorMessage(String title, String message) {
    showSnackBar(context, title, message);
    context.read<ChangePasswordProvider>().resetState();
  }
}
