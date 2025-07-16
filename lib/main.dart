import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/core/config.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/splash_screen.dart';
import 'package:hotdeal_with_hono/src/presentation/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const env = String.fromEnvironment('ENV', defaultValue: 'local');
  await dotenv.load(fileName: ".env.$env");
  final baseUrl = dotenv.env['API_BASE_URL'];
  if (baseUrl == null) {
    throw Exception('API_BASE_URL is not defined in .env file');
  }
  final appConfig = AppConfig(baseUrl: baseUrl);

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(appConfig),
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
      title: 'Hotdeal with Hono',
      theme: appTheme,
      home: const SplashScreen(),
    );
  }
}
