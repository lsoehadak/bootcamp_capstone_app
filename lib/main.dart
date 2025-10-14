import 'package:capstone_app/firebase_options.dart';
import 'package:capstone_app/providers/home_provider.dart';
import 'package:capstone_app/providers/login_provider.dart';
import 'package:capstone_app/services/api_service.dart';
import 'package:capstone_app/services/firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() async {
  // Jika menggunakan Firebase, pastikan setup sudah benar lalu uncomment baris di bawah:
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ApiService()),
        Provider(create: (context) => FirestoreService()),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(context.read<ApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(context.read<FirestoreService>()),
        ),
      ],
      child: const App(),
    );
  }
}
