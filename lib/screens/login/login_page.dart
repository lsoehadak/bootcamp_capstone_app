import 'package:capstone_app/providers/login_provider.dart';
import 'package:capstone_app/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:capstone_app/utils/auth_error_messages.dart';
import 'package:capstone_app/screens/common/widgets/custom_button.dart';
import 'package:capstone_app/screens/common/widgets/custom_text_field.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/register_provider.dart';
import '../../services/api_service.dart';
import '../register/register_page.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mq = MediaQuery.of(context);
            final vw = mq.size.width;
            final logoSize = (vw * 0.28).clamp(72.0, 140.0);
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
                bottom: mq.viewInsets.bottom + 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - mq.viewInsets.bottom,
                ),
                child: IntrinsicHeight(
                  child: Consumer<LoginProvider>(
                    builder: (context, provider, child) {
                      return AutofillGroup(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                width: logoSize,
                                height: logoSize,
                                child: Image.asset(
                                  'assets/icons/logo_app.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Selamat Datang di App',
                              style: AppTextStyles.titleText.copyWith(
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Silahkan login terlebih dahulu untuk menikmati seluruh fitur aplikasi',
                              style: AppTextStyles.bodyLowEmText,
                            ),
                            const SizedBox(height: 32),
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
                            const Text(
                              'Password',
                              style: AppTextStyles.labelText,
                            ),
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
                            Builder(
                              builder: (context) {
                                final auth = Provider.of<AuthProvider>(context);
                                final isLoading = auth.isLoading;
                                return CustomDefaultButton(
                                  label: isLoading ? 'Memproses...' : 'Masuk',
                                  isEnabled:
                                      provider.isFormCompleted && !isLoading,
                                  onClick: () async {
                                    try {
                                      await auth.login(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                      );
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/home',
                                      );
                                    } catch (e) {
                                      String message =
                                          'Login gagal. Silakan coba lagi.';
                                      if (e is fb.FirebaseAuthException) {
                                        message = mapFirebaseAuthError(e.code);
                                      }
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text(message)),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'atau',
                                  style: AppTextStyles.bodySmallLowEmText,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            CustomOutlinedButton(
                              label: 'Buat Akun',
                              onClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ChangeNotifierProvider(
                                        create: (context) => RegisterProvider(
                                          context.read<ApiService>(),
                                        ),
                                        child: const RegisterPage(),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
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

  // Removed focus change method as we're simplifying the implementation

  bool _checkAllFieldsFilled() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }
}
