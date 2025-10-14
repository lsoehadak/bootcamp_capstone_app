import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:capstone_app/providers/auth_provider.dart';
import 'package:capstone_app/utils/auth_error_messages.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/register_provider.dart';
import '../common/widgets/custom_button.dart';
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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Akun')),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mq = MediaQuery.of(context);
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: mq.viewInsets.bottom + 16,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - mq.viewInsets.bottom,
                ),
                child: IntrinsicHeight(
                  child: Consumer<RegisterProvider>(
                    builder: (context, provider, child) {
                      final auth = Provider.of<AuthProvider>(context);
                      final isLoading = auth.isLoading;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Buat Akun Baru',
                            style: AppTextStyles.titleText.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 6),
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
                            onChanged: (value) =>
                                provider.changeFormCompletionStatus(
                                  _checkAllFieldsFilled(),
                                ),
                          ),
                          const SizedBox(height: 12),
                          const Text('Email', style: AppTextStyles.labelText),
                          const SizedBox(height: 8),
                          CustomDefaultTextField(
                            controller: _emailController,
                            hint: 'Masukkan Email',
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) =>
                                provider.changeFormCompletionStatus(
                                  _checkAllFieldsFilled(),
                                ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Password',
                            style: AppTextStyles.labelText,
                          ),
                          const SizedBox(height: 8),
                          CustomPasswordTextField(
                            controller: _passwordController,
                            isObscure: provider.isPasswordObscured,
                            hint: 'Masukkan Password',
                            onReveal: provider.togglePasswordVisibility,
                            onChanged: (value) =>
                                provider.changeFormCompletionStatus(
                                  _checkAllFieldsFilled(),
                                ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Konfirmasi Password',
                            style: AppTextStyles.labelText,
                          ),
                          const SizedBox(height: 8),
                          CustomPasswordTextField(
                            controller: _confirmPasswordController,
                            isObscure: provider.isConfirmPasswordObscured,
                            hint: 'Masukkan Password',
                            onReveal: provider.toggleConfirmPasswordVisibility,
                            onChanged: (value) =>
                                provider.changeFormCompletionStatus(
                                  _checkAllFieldsFilled(),
                                ),
                          ),
                          const SizedBox(height: 24),
                          CustomDefaultButton(
                            label: isLoading ? 'Memproses...' : 'Buat',
                            isEnabled: provider.isFormCompleted && !isLoading,
                            onClick: () async {
                              try {
                                await auth.register(
                                  _nameController.text.trim(),
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                  'parent',
                                );
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                );
                              } catch (e) {
                                String message =
                                    'Registrasi gagal. Silakan coba lagi.';
                                if (e is fb.FirebaseAuthException) {
                                  message = mapFirebaseAuthError(e.code);
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message)),
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
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
}
