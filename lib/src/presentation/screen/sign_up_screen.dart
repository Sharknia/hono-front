import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/presentation/provider/auth_provider.dart';
import 'package:hotdeal_with_hono/src/presentation/theme/app_theme.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_button.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_text_field.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final nicknameController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordCheckController = TextEditingController();

    final signUpState = ref.watch(signUpViewModelProvider);

    ref.listen(signUpViewModelProvider, (previous, next) {
      if (next.token != null) {
        // 회원가입 성공
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign up successful! Please log in.')),
        );
        Navigator.of(context).pop();
      }
      if (next.error != null) {
        // 에러 발생
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${next.error}')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.p32),
              CustomTextField(
                labelText: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: AppSpacing.p16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Nickname',
                      controller: nicknameController,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.p8),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.p8),
                    child: CustomButton(
                      onPressed: () {
                        ref
                            .read(signUpViewModelProvider.notifier)
                            .checkNickname(nicknameController.text);
                      },
                      text: 'Check',
                    ),
                  )
                ],
              ),
              if (signUpState.isCheckingNickname)
                const Padding(
                  padding: EdgeInsets.only(top: AppSpacing.p8),
                  child: Text('Checking...'),
                )
              else if (!signUpState.isNicknameAvailable)
                const Padding(
                  padding: EdgeInsets.only(top: AppSpacing.p8),
                  child: Text(
                    'This nickname is already taken.',
                    style: TextStyle(color: AppColors.error),
                  ),
                ),
              const SizedBox(height: AppSpacing.p16),
              CustomTextField(
                labelText: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: AppSpacing.p16),
              CustomTextField(
                labelText: 'Confirm Password',
                controller: passwordCheckController,
                obscureText: true,
              ),
              const SizedBox(height: AppSpacing.p32),
              CustomButton(
                text: 'Sign Up',
                isLoading: signUpState.isLoading,
                onPressed: () {
                  ref.read(signUpViewModelProvider.notifier).signUp(
                        email: emailController.text,
                        password: passwordController.text,
                        passwordCheck: passwordCheckController.text,
                        nickname: nicknameController.text,
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
