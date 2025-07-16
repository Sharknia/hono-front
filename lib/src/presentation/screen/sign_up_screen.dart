import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/presentation/provider/auth_provider.dart';
import 'package:hotdeal_with_hono/src/presentation/state/sign_up_state.dart';
import 'package:hotdeal_with_hono/src/presentation/theme/app_theme.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_alert_dialog.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_button.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_text_field.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late final TextEditingController emailController;
  late final TextEditingController nicknameController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordCheckController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nicknameController = TextEditingController();
    passwordController = TextEditingController();
    passwordCheckController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    nicknameController.dispose();
    passwordController.dispose();
    passwordCheckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpViewModelProvider);
    final signUpViewModel = ref.read(signUpViewModelProvider.notifier);

    ref.listen<SignUpState>(signUpViewModelProvider, (previous, next) async {
      if (next.isSignUpSuccess &&
          next.email != null &&
          next.password != null) {
        // Auto-login after successful sign-up
        ref
            .read(loginViewModelProvider.notifier)
            .login(next.email!, next.password!);
        
        final result = await showCustomDialog(
          context: context,
          dialogType: DialogType.success,
          title: '성공',
          content: '회원가입이 완료되었습니다. 자동으로 로그인합니다.',
        );
        if (result == true && context.mounted) {
          Navigator.of(context).pop();
        }
      }
      if (next.error != null && (previous?.error != next.error)) {
        showCustomDialog(
          context: context,
          dialogType: DialogType.error,
          title: '오류',
          content: next.error!,
        );
      }
      if (previous?.isCheckingNickname == true &&
          next.isCheckingNickname == false) {
        if (!next.isNicknameAvailable) {
          showCustomDialog(
            context: context,
            dialogType: DialogType.error,
            title: '닉네임 확인',
            content: '이미 사용 중인 닉네임입니다.',
          );
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
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
                labelText: '이메일',
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
                      labelText: '닉네임',
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
                      text: '중복 확인',
                      isLoading: signUpState.isCheckingNickname,
                    ),
                  )
                ],
              ),
              if (signUpState.isNicknameFixed)
                const Padding(
                  padding: EdgeInsets.only(top: AppSpacing.p8),
                  child: Text(
                    '사용 가능한 닉네임입니다.',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              const SizedBox(height: AppSpacing.p16),
              CustomTextField(
                labelText: '비밀번호',
                controller: passwordController,
                obscureText: true,
                onChanged: (password) => signUpViewModel.validatePassword(
                    password, passwordCheckController.text),
                errorText: signUpState.passwordError,
              ),
              const SizedBox(height: AppSpacing.p16),
              CustomTextField(
                labelText: '비밀번호 확인',
                controller: passwordCheckController,
                obscureText: true,
                onChanged: (passwordCheck) => signUpViewModel.validatePassword(
                    passwordController.text, passwordCheck),
                errorText: signUpState.passwordError,
              ),
              const SizedBox(height: AppSpacing.p32),
              CustomButton(
                text: '가입하기',
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
