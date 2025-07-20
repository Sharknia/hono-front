import 'package:hotdeal_tuum/data/api/services/auth_api.dart';

abstract class AuthRepository {
  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  AuthRepositoryImpl({required this.authApi});

  @override
  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await authApi.login(email: email, password: password, rememberMe: rememberMe);
  }
}
