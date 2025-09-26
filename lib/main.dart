import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/auth_provider.dart';
import 'providers/child_provider.dart';
import 'providers/measurement_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/tips_provider.dart';

void main() {
  // Jika menggunakan Firebase, pastikan setup sudah benar lalu uncomment baris di bawah:
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TipsProvider()),
        ChangeNotifierProvider(create: (_) => ChildProvider()),
        ChangeNotifierProvider(create: (_) => MeasurementProvider()),
      ],
      child: const App(),
    );
  }
}
