import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotdeal_tuum/data/api/interceptors/auth_interceptor.dart';
import 'package:hotdeal_tuum/data/services/token_storage_service.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient(TokenStorageService tokenStorageService) {
    final baseUrl = dotenv.env['BASE_URL'];
    if (baseUrl == null) {
      throw Exception('BASE_URL not found in .env file');
    }

    const timeout = Duration(seconds: 30);

    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    _dio = Dio(options);
    _dio.interceptors.add(
      AuthInterceptor(storage: tokenStorageService, dio: _dio),
    );
  }

  Dio get dio => _dio;
}
