import 'package:dio/dio.dart';
import 'package:hotdeal_tuum/data/models/login_response_model.dart';
import 'package:hotdeal_tuum/data/services/token_storage_service.dart';

class AuthApi {
  final Dio dio;
  final TokenStorageService tokenStorageService;

  AuthApi({required this.dio, required this.tokenStorageService});

  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final loginResponse = LoginResponseModel.fromJson(response.data);
        await tokenStorageService.saveTokens(
          accessToken: loginResponse.accessToken,
          refreshToken: loginResponse.refreshToken,
          rememberMe: rememberMe,
        );
      }
    } catch (e) {
      // Handle error
      rethrow;
    }
  }
}
