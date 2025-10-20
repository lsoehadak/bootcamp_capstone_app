import 'package:capstone_app/screens/splash/splash_screen_page.dart';
import 'package:capstone_app/utils/app_colors.dart';
import 'package:capstone_app/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat',
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: AppTextStyles.titleText.copyWith(fontSize: 20, fontFamily: 'Montserrat'),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.mainThemeColor,
      )
    );

    return MaterialApp(
      title: 'Siaga Gizi',
      theme: lightTheme,
      home: const SplashScreenPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
