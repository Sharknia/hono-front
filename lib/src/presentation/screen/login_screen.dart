import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/presentation/provider/auth_provider.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/sign_up_screen.dart';
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
                '다시 오셨네요!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: AppSpacing.p8),
              Text(
                '로그인하여 계속 진행하세요',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.p32 * 2),

              // Text Fields & Form
              Form(
                child: Column(
                  children: [
                    CustomTextField(
                      key: const ValueKey('emailField'),
                      controller: emailController,
                      labelText: '이메일',
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.p16),
                    CustomTextField(
                      key: const ValueKey('passwordField'),
                      controller: passwordController,
                      labelText: '비밀번호',
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        ref.read(loginViewModelProvider.notifier).login(
                              emailController.text,
                              passwordController.text,
                            );
                      },
                    ),
                  ],
                ),
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
                text: '로그인',
                isLoading: loginState.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                ),
              ),
              const SizedBox(height: AppSpacing.p16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: Text(
                  "계정이 없으신가요? 회원가입",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
