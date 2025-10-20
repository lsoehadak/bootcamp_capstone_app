import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/register_provider.dart';
import '../../utils/ui_state.dart';
import '../common/widgets/custom_button.dart';
import '../common/widgets/custom_snackbar.dart';
import '../common/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final resultState = context.watch<RegisterProvider>().uiState;

    if (resultState is UiErrorState<bool>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorMessage(resultState.errorTitle, resultState.errorMessage);
      });
    } else if (resultState is UiSuccessState<bool>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context, true);
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<RegisterProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buat Akun Baru',
                  style: AppTextStyles.titleText.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Silahkan lengkapi form di bawah ini untuk membuat akun baru',
                  style: AppTextStyles.bodyLowEmText,
                ),
                const SizedBox(height: 32),
                const Text('Nama', style: AppTextStyles.labelText),
                const SizedBox(height: 8),
                CustomDefaultTextField(
                  controller: _nameController,
                  hint: 'Masukkan Nama',
                  onChanged: (value) {
                    provider.changeFormCompletionStatus(
                      _checkAllFieldsFilled(),
                    );
                  },
                ),
                const SizedBox(height: 16),
                const Text('Email', style: AppTextStyles.labelText),
                const SizedBox(height: 8),
                CustomDefaultTextField(
                  controller: _emailController,
                  hint: 'Masukkan Email',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    provider.changeFormCompletionStatus(
                      _checkAllFieldsFilled(),
                    );
                  },
                ),
                const SizedBox(height: 16),
                const Text('Password', style: AppTextStyles.labelText),
                const SizedBox(height: 8),
                CustomPasswordTextField(
                  controller: _passwordController,
                  isObscure: true,
                  hint: 'Masukkan Password',
                  onReveal: () {
                    provider.togglePasswordVisibility();
                  },
                  onChanged: (value) {
                    provider.changeFormCompletionStatus(
                      _checkAllFieldsFilled(),
                    );
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Konfirmasi Password',
                  style: AppTextStyles.labelText,
                ),
                const SizedBox(height: 8),
                CustomPasswordTextField(
                  controller: _confirmPasswordController,
                  isObscure: true,
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
                  label: 'Buat',
                  isEnabled: provider.isFormCompleted,
                  isLoading: provider.uiState is UiLoadingState,
                  onClick: () {
                    provider.register(
                      _emailController.text,
                      _passwordController.text,
                      _nameController.text,
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
    return _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;
  }

  void _showErrorMessage(String title, String message) {
    showSnackBar(context, title, message);
    context.read<RegisterProvider>().resetState();
  }
}
