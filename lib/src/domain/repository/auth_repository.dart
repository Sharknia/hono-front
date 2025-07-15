import '../model/token.dart';

abstract class AuthRepository {
  Future<Token> login(String email, String password);
}
