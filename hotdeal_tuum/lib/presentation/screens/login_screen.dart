import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hotdeal_tuum/core/di/providers.dart';
import 'package:hotdeal_tuum/domain/providers/auth/auth_state.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the auth state for side-effects like navigation or showing errors
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        authenticated: () {
          // Navigate to home on successful authentication
          context.go('/home');
        },
        error: (message) {
          // Show a snackbar on error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
        orElse: () {}, // Do nothing for other states
      );
    });

    final authState = ref.watch(authNotifierProvider);
    final emailController = TextEditingController(text: 'test@test.com');
    final passwordController = TextEditingController(text: 'password');

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            authState.maybeWhen(
              loading: () => const CircularProgressIndicator(),
              orElse: () => ElevatedButton(
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).login(
                        email: emailController.text,
                        password: passwordController.text,
                        rememberMe: true,
                      );
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}