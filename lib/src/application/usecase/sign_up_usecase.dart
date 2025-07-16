import 'package:hotdeal_with_hono/src/domain/model/token.dart';
import 'package:hotdeal_with_hono/src/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Future<void> call({
    required String email,
    required String password,
    required String passwordCheck,
    required String nickname,
  }) {
    if (email.isEmpty || password.isEmpty || nickname.isEmpty) {
      throw ArgumentError('Email, password, and nickname cannot be empty');
    }
    if (password != passwordCheck) {
      throw ArgumentError('Passwords do not match');
    }
    return _authRepository.signUp(
      email: email,
      password: password,
      nickname: nickname,
    );
  }
}
