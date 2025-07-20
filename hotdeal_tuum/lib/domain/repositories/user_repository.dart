import 'package:hotdeal_tuum/data/api/services/user_api.dart';

abstract class UserRepository {
  Future<bool> checkNickname(String nickname);
}

class UserRepositoryImpl implements UserRepository {
  final UserApi userApi;

  UserRepositoryImpl({required this.userApi});

  @override
  Future<bool> checkNickname(String nickname) async {
    return await userApi.checkNickname(nickname);
  }
}
