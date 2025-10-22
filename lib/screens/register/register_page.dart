import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/register_provider.dart';
import '../../utils/app_colors.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<RegisterProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 75,
                  height: 75,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.mainThemeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    'assets/icons/logo_app.png',
                    color: Colors.white,
                    colorBlendMode: BlendMode.srcATop,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Buat Akun Baru',
                  style: AppTextStyles.titleText.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Silahkan lengkapi form di bawah ini untuk membuat akun baru',
                  style: AppTextStyles.bodyLowEmText,
                ),
                const SizedBox(height: 24),
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
                const SizedBox(height: 4),
                const Text('* Password minimal 6 karakter', style: AppTextStyles.captionLowEmText,),
                const SizedBox(height: 8),
                CustomPasswordTextField(
                  controller: _passwordController,
                  isObscure: provider.isPasswordObscured,
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
        _passwordController.text.length >= 6 &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text;
  }

  void _showErrorMessage(String title, String message) {
    showSnackBar(context, title, message);
    context.read<RegisterProvider>().resetState();
  }
}
