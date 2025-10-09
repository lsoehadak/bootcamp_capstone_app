import 'package:capstone_app/providers/home_provider.dart';
import 'package:capstone_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/auth_provider.dart';
import 'providers/child_provider.dart';
import 'providers/child_tracking_provider.dart';
import 'providers/measurement_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/tips_provider.dart';

void main() async {
  // Jika menggunakan Firebase, pastikan setup sudah benar lalu uncomment baris di bawah:
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
        ChangeNotifierProvider(
          create: (context) => HomeProvider(context.read<ApiService>()),
        ),
      ],
      child: const App(),
    );
  }
}
