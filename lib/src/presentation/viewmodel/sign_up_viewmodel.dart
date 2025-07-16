import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/application/usecase/check_nickname_usecase.dart';
import 'package:hotdeal_with_hono/src/application/usecase/sign_up_usecase.dart';
import 'package:hotdeal_with_hono/src/presentation/state/sign_up_state.dart';

class SignUpViewModel extends StateNotifier<SignUpState> {
  final SignUpUseCase _signUpUseCase;
  final CheckNicknameUseCase _checkNicknameUseCase;

  SignUpViewModel(this._signUpUseCase, this._checkNicknameUseCase)
      : super(const SignUpState());

  Future<void> signUp({
    required String email,
    required String password,
    required String passwordCheck,
    required String nickname,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    await Future.delayed(Duration.zero); // 상태 변경이 반영될 시간을 줍니다.
    try {
      final token = await _signUpUseCase.call(
        email: email,
        password: password,
        passwordCheck: passwordCheck,
        nickname: nickname,
      );
      state = state.copyWith(isLoading: false, token: token);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> checkNickname(String nickname) async {
    state = state.copyWith(isCheckingNickname: true);
    try {
      final isAvailable = await _checkNicknameUseCase.call(nickname);
      state = state.copyWith(
          isCheckingNickname: false, isNicknameAvailable: isAvailable);
    } catch (e) {
      state = state.copyWith(isCheckingNickname: false);
      // Handle error, maybe show a message to the user
    }
  }
}
