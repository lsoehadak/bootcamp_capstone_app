import 'package:capstone_app/screens/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final lightColorScheme = ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        );
        final darkColorScheme = ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        );

        final lightTheme = ThemeData(
          // colorScheme: lightColorScheme,
          // useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Montserrat'
          // appBarTheme: AppBarTheme(
          //   backgroundColor: lightColorScheme.primary,
          //   foregroundColor: lightColorScheme.onPrimary,
          //   elevation: 0.5,
          // ),
          // inputDecorationTheme: InputDecorationTheme(
          //   border: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(8),
          //     borderSide: BorderSide.none,
          //   ),
          //   filled: true,
          //   fillColor: Colors.white,
          // ),
          // elevatedButtonTheme: ElevatedButtonThemeData(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: lightColorScheme.primary,
          //     foregroundColor: lightColorScheme.onPrimary,
          //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          // ),
          // cardTheme: CardThemeData(
          //   elevation: 1,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   color: lightColorScheme.surface,
          // ),
        );

        // final darkTheme = ThemeData(
        //   colorScheme: darkColorScheme,
        //   useMaterial3: true,
        //   brightness: Brightness.dark,
        //   scaffoldBackgroundColor: darkColorScheme.surface,
        //   appBarTheme: AppBarTheme(
        //     backgroundColor: darkColorScheme.primary,
        //     foregroundColor: darkColorScheme.onPrimary,
        //     elevation: 0.5,
        //   ),
        //   inputDecorationTheme: InputDecorationTheme(
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(8),
        //       borderSide: BorderSide.none,
        //     ),
        //     filled: true,
        //     fillColor: darkColorScheme.surfaceContainerHighest,
        //   ),
        //   elevatedButtonTheme: ElevatedButtonThemeData(
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: darkColorScheme.primary,
        //       foregroundColor: darkColorScheme.onPrimary,
        //       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //     ),
        //   ),
        //   cardTheme: CardThemeData(
        //     elevation: 1,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //     color: darkColorScheme.surface,
        //   ),
        // );

        return MaterialApp(
          title: 'Siaga Gizi',
          theme: lightTheme,
          // darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: const LoginPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
