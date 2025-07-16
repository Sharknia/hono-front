import 'package:hotdeal_with_hono/src/domain/repository/auth_repository.dart';

class CheckNicknameUseCase {
  final AuthRepository _authRepository;

  CheckNicknameUseCase(this._authRepository);

  Future<bool> call(String nickname) {
    if (nickname.isEmpty) {
      throw ArgumentError('Nickname cannot be empty');
    }
    return _authRepository.checkNicknameAvailability(nickname);
  }
}
