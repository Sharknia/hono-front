import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/core/config.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/login_screen.dart';
import 'package:hotdeal_with_hono/src/presentation/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  const env = String.fromEnvironment('ENV', defaultValue: 'local');
  await dotenv.load(fileName: ".env.$env");
  final baseUrl = dotenv.env['API_BASE_URL'];
  if (baseUrl == null) {
    throw Exception('API_BASE_URL is not defined in .env file');
  }

  // Create config instance
  final config = AppConfig(baseUrl: baseUrl);

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(config),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hono',
      theme: appTheme,
      home: const LoginScreen(),
    );
  }
}
