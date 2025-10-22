import 'package:capstone_app/screens/common/widgets/custom_button.dart';
import 'package:capstone_app/screens/login/login_page.dart';
import 'package:capstone_app/screens/register/register_page.dart';
import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/login_provider.dart';
import '../../providers/register_provider.dart';
import '../../services/auth_service.dart';
import '../common/widgets/custom_snackbar.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.mainThemeColor.withOpacity(0.4),
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset('assets/icons/il_welcome_crop.png'),
              ),
              const SizedBox(height: 24),
              Text(
                'Siaga Gizi',
                style: AppTextStyles.titleText.copyWith(fontSize: 30),
              ),
              const SizedBox(height: 8),
              const Text(
                'Deteksi cepat status gizi anak untuk pencegahan stunting dan masa depan yang lebih sehat.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyText,
              ),
              const SizedBox(height: 24),
              CustomDefaultButton(
                label: 'Masuk',
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ChangeNotifierProvider(
                          create: (context) =>
                              LoginProvider(context.read<AuthService>()),
                          child: const LoginPage(),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomOutlinedButton(
                label: 'Buat Akun',
                onClick: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ChangeNotifierProvider(
                          create: (context) =>
                              RegisterProvider(context.read<AuthService>()),
                          child: const RegisterPage(),
                        );
                      },
                    ),
                  );

                  if (result != null && result) {
                    if (!context.mounted) return;
                    showSnackBar(
                      context,
                      'Akun Berhasil Dibuat',
                      'Silahkan masuk menggunakan akun yang baru Anda buat',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
