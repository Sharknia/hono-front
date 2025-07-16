import '../../domain/model/token.dart';
import '../../domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<Token> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw ArgumentError('Email and password cannot be empty');
    }
    return _authRepository.login(email, password);
  }
}
