import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/presentation/provider/auth_provider.dart';
import 'package:hotdeal_with_hono/src/presentation/state/sign_up_state.dart';
import 'package:hotdeal_with_hono/src/presentation/theme/app_theme.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_alert_dialog.dart';
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
    final signUpViewModel = ref.read(signUpViewModelProvider.notifier);

    ref.listen<SignUpState>(signUpViewModelProvider, (previous, next) {
      if (next.token != null) {
        showCustomDialog(
          context: context,
          dialogType: DialogType.success,
          title: 'Success',
          content: 'Sign up successful! Please log in.',
          onConfirm: () => Navigator.of(context).pop(),
        );
      }
      if (next.error != null && (previous?.error != next.error)) {
        showCustomDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Error',
          content: next.error!,
        );
      }
      if (previous?.isCheckingNickname == true &&
          next.isCheckingNickname == false) {
        if (!next.isNicknameAvailable) {
          showCustomDialog(
            context: context,
            dialogType: DialogType.error,
            title: 'Nickname Check',
            content: 'This nickname is already taken.',
          );
        }
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
                onChanged: signUpViewModel.validateEmail,
                errorText: signUpState.emailError,
              ),
              const SizedBox(height: AppSpacing.p16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Nickname',
                      controller: nicknameController,
                      onChanged: signUpViewModel.validateNickname,
                      errorText: signUpState.nicknameError,
                      enabled: !signUpState.isNicknameFixed,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.p8),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.p8),
                    child: CustomButton(
                      onPressed: signUpState.isNicknameFixed
                          ? null
                          : () {
                              signUpViewModel
                                  .checkNickname(nicknameController.text);
                            },
                      text: 'Check',
                      isLoading: signUpState.isCheckingNickname,
                    ),
                  )
                ],
              ),
              if (signUpState.isNicknameFixed)
                const Padding(
                  padding: EdgeInsets.only(top: AppSpacing.p8),
                  child: Text(
                    'Nickname is available and fixed.',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              const SizedBox(height: AppSpacing.p16),
              CustomTextField(
                labelText: 'Password',
                controller: passwordController,
                obscureText: true,
                onChanged: (password) => signUpViewModel.validatePassword(
                    password, passwordCheckController.text),
                errorText: signUpState.passwordError,
              ),
              const SizedBox(height: AppSpacing.p16),
              CustomTextField(
                labelText: 'Confirm Password',
                controller: passwordCheckController,
                obscureText: true,
                onChanged: (passwordCheck) => signUpViewModel.validatePassword(
                    passwordController.text, passwordCheck),
                errorText: signUpState.passwordError,
              ),
              const SizedBox(height: AppSpacing.p32),
              CustomButton(
                text: 'Sign Up',
                isLoading: signUpState.isLoading,
                onPressed: signUpState.isFormValid
                    ? () {
                        signUpViewModel.signUp(
                          email: emailController.text,
                          password: passwordController.text,
                          passwordCheck: passwordCheckController.text,
                          nickname: nicknameController.text,
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
