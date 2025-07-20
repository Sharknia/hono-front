import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotdeal_tuum/routes/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay for splash screen
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.goNamed(AppRouteNames.login);
      }
    });
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
            Text('Hotdeal Tuum'),
          ],
        ),
      ),
    );
  }
}
