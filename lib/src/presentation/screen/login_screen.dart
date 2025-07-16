import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/presentation/provider/auth_provider.dart';
import 'package:hotdeal_with_hono/src/presentation/state/login_state.dart';
import 'package:hotdeal_with_hono/src/presentation/theme/app_theme.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_button.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_text_field.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    ref.listen<LoginState>(loginViewModelProvider, (previous, next) {
      next.whenOrNull(
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.p24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo or Welcome Message
              Text(
                'Welcome Back',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: AppSpacing.p8),
              Text(
                'Sign in to continue',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.p32 * 2),

              // Text Fields
              CustomTextField(
                key: const ValueKey('emailField'),
                controller: emailController,
                labelText: 'Email',
              ),
              const SizedBox(height: AppSpacing.p16),
              CustomTextField(
                key: const ValueKey('passwordField'),
                controller: passwordController,
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: AppSpacing.p32),

              // Login Button
              CustomButton(
                key: const ValueKey('loginButton'),
                onPressed: () {
                  ref.read(loginViewModelProvider.notifier).login(
                        emailController.text,
                        passwordController.text,
                      );
                },
                text: 'Login',
                isLoading: loginState.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
