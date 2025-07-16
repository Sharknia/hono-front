import '../model/token.dart';

abstract class AuthRepository {
  Future<Token> login(String email, String password);
  Future<Token> signUp({
    required String email,
    required String password,
    required String nickname,
  });
  Future<bool> checkNicknameAvailability(String nickname);
  Future<bool> checkEmailAvailability(String email);
}
