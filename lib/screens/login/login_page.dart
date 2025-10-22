import 'package:capstone_app/providers/login_provider.dart';
import 'package:capstone_app/screens/common/widgets/custom_button.dart';
import 'package:capstone_app/screens/common/widgets/custom_text_field.dart';
import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/ui_state.dart';
import '../common/widgets/custom_snackbar.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resultState = context.watch<LoginProvider>().uiState;

    if (resultState is UiErrorState<bool>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorMessage(resultState.errorTitle, resultState.errorMessage);
      });
    } else if (resultState is UiSuccessState<bool>) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _toHomePage();
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<LoginProvider>(
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
                  'Masuk ke Akun',
                  style: AppTextStyles.titleText.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Silakan masuk ke akun Anda untuk memulai analisis risiko stunting',
                  style: AppTextStyles.bodyText,
                ),
                const SizedBox(height: 24),
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
                  hint: 'Masukkan Password',
                  isObscure: provider.isPasswordObscured,
                  onReveal: () {
                    provider.togglePasswordVisibility();
                  },
                  onChanged: (value) {
                    provider.changeFormCompletionStatus(
                      _checkAllFieldsFilled(),
                    );
                  },
                ),
                const SizedBox(height: 32),
                CustomDefaultButton(
                  label: 'Masuk',
                  isEnabled: provider.isFormCompleted,
                  isLoading: provider.uiState is UiLoadingState,
                  onClick: () {
                    provider.login(
                      _emailController.text,
                      _passwordController.text,
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
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  void _showErrorMessage(String title, String message) {
    showSnackBar(context, title, message);
    context.read<LoginProvider>().resetState();
  }

  void _toHomePage() {
    context.read<LoginProvider>().resetState();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ),
    );
  }
}
