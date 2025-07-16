import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/presentation/provider/auth_provider.dart';
import 'package:hotdeal_with_hono/src/presentation/state/login_state.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    ref.listen<LoginState>(loginViewModelProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        success: (token) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Success: ${token.accessToken}')),
          );
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Failed: $message')),
          );
        },
      );
    });

    final loginState = ref.watch(loginViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              key: const ValueKey('emailField'),
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              key: const ValueKey('passwordField'),
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            loginState.when(
              initial: () => ElevatedButton(
                key: const ValueKey('loginButton'),
                onPressed: () {
                  ref.read(loginViewModelProvider.notifier).login(
                        emailController.text,
                        passwordController.text,
                      );
                },
                child: const Text('Login'),
              ),
              loading: () => const CircularProgressIndicator(),
              success: (_) => ElevatedButton(
                key: const ValueKey('loginButton'),
                onPressed: null, // Prevent multiple logins
                child: const Text('Login'),
              ),
              error: (_) => ElevatedButton(
                key: const ValueKey('loginButton'),
                onPressed: () {
                  ref.read(loginViewModelProvider.notifier).login(
                        emailController.text,
                        passwordController.text,
                      );
                },
                child: const Text('Retry Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
