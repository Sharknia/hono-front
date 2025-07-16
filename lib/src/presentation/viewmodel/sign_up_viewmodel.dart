import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/application/usecase/check_nickname_usecase.dart';
import 'package:hotdeal_with_hono/src/application/usecase/sign_up_usecase.dart';
import 'package:hotdeal_with_hono/src/presentation/state/sign_up_state.dart';

class SignUpViewModel extends StateNotifier<SignUpState> {
  final SignUpUseCase _signUpUseCase;
  final CheckNicknameUseCase _checkNicknameUseCase;

  SignUpViewModel(this._signUpUseCase, this._checkNicknameUseCase)
      : super(const SignUpState());

  void validateEmail(String email) {
    if (email.isEmpty) {
      state = state.copyWith(emailError: '이메일을 입력해주세요.');
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      state = state.copyWith(emailError: '올바른 이메일 형식이 아닙니다.');
    } else {
      state = state.copyWith(emailError: null);
    }
  }

  void validateNickname(String nickname) {
    if (nickname.isEmpty) {
      state = state.copyWith(nicknameError: '닉네임을 입력해주세요.');
    } else {
      state = state.copyWith(nicknameError: null);
    }
    // Reset nickname check on change
    if (state.isNicknameFixed) {
      state = state.copyWith(isNicknameFixed: false, isNicknameAvailable: true);
    }
  }

  void validatePassword(String password, String passwordCheck) {
    if (password.isEmpty || passwordCheck.isEmpty) {
      state = state.copyWith(passwordError: '비밀번호를 입력해주세요.');
    } else if (password != passwordCheck) {
      state = state.copyWith(passwordError: '비밀번호가 일치하지 않습니다.');
    } else {
      state = state.copyWith(passwordError: null);
    }
  }

  Future<void> checkNickname(String nickname) async {
    state = state.copyWith(isCheckingNickname: true);
    try {
      final isAvailable = await _checkNicknameUseCase.call(nickname);
      state = state.copyWith(
        isCheckingNickname: false,
        isNicknameAvailable: isAvailable,
        isNicknameFixed: isAvailable, // Fix nickname if available
      );
    } catch (e) {
      state = state.copyWith(isCheckingNickname: false);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String passwordCheck,
    required String nickname,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    await Future.delayed(Duration.zero);
    try {
      await _signUpUseCase.call(
        email: email,
        password: password,
        passwordCheck: passwordCheck,
        nickname: nickname,
      );
      state = state.copyWith(
          isLoading: false,
          isSignUpSuccess: true,
          email: email,
          password: password);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
