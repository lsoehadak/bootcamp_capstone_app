import 'package:capstone_app/providers/login_provider.dart';
import 'package:capstone_app/screens/common/widgets/custom_button.dart';
import 'package:capstone_app/screens/common/widgets/custom_text_field.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/home_provider.dart';
import '../../providers/register_provider.dart';
import '../../services/api_service.dart';
import '../home/home_page.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Consumer<LoginProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset('assets/icons/logo_app.png'),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Selamat Datang di App',
                    style: AppTextStyles.titleText.copyWith(fontSize: 24),
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
                    onClick: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('atau', style: AppTextStyles.bodySmallLowEmText),
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
                              create: (context) =>
                                  RegisterProvider(context.read<ApiService>()),
                              child: const RegisterPage(),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  bool _checkAllFieldsFilled() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }
}
