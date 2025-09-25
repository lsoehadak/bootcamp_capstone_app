import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart'; // Uncomment this
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/auth_provider.dart';
import 'providers/child_provider.dart';
import 'providers/measurement_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/tips_provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // TODO:
  // 1. Complete your Firebase setup for Android.
  // 2. Uncomment the Firebase.initializeApp call.
  // await Firebase.initializeApp(
  //   // options: DefaultFirebaseOptions.currentPlatform, // This requires firebase_options.dart
  // );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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