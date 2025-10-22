import 'package:capstone_app/providers/splash_screen_provider.dart';
import 'package:capstone_app/screens/home/home_page.dart';
import 'package:capstone_app/screens/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isUserLogIn = context.watch<SplashScreenProvider>().isUserLogin;

    if (isUserLogIn != null && isUserLogIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // navigate to home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    } else if(isUserLogIn != null && !isUserLogIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()),
        );
      });
    }

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset('assets/icons/logo_app.png'),
        ),
      ),
    );
  }
}
