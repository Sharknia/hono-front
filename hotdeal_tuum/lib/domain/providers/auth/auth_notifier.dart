import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotdeal_tuum/domain/providers/auth/auth_state.dart';
import 'package:hotdeal_tuum/domain/repositories/auth_repository.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.initial());

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    state = const AuthState.loading();
    try {
      await _authRepository.login(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );
      state = const AuthState.authenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
