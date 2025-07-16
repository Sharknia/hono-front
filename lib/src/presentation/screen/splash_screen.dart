import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/infrastructure/service/token_storage_service.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/login_screen.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/keyword_screen.dart'; // Will be created later

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    final tokenStorageService = ref.read(tokenStorageServiceProvider);
    final accessToken = await tokenStorageService.getAccessToken();

    // Add a small delay to show splash screen
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    if (accessToken != null) {
      // TODO: Add token validation logic here (e.g., call a profile API)
      // For now, we'll assume the token is valid if it exists.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const KeywordScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('잠시만 기다려주세요...'),
          ],
        ),
      ),
    );
  }
}
