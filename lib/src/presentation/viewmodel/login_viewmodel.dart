import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_with_hono/src/application/usecase/login_usecase.dart';
import 'package:hotdeal_with_hono/src/presentation/state/login_state.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    state = const LoginState.loading();
    await Future.delayed(Duration.zero); // 상태 변경이 반영될 시간을 줍니다.
    try {
      final token = await _loginUseCase.call(email, password);
      state = LoginState.success(token);
    } catch (e) {
      state = LoginState.error(e.toString());
    }
  }
}
