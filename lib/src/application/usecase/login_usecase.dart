import '../../domain/model/token.dart';
import '../../domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<Token> call(String email, String password) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
