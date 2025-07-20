import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotdeal_tuum/routes/route_names.dart';

class ErrorScreen extends StatelessWidget {
  final String? error;
  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('오류')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error ?? '페이지를 찾을 수 없습니다.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRouteNames.home),
              child: const Text('홈으로 가기'),
            ),
          ],
        ),
      ),
    );
  }
}
