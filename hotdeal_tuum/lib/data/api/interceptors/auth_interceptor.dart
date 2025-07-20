import 'package:dio/dio.dart';
import 'package:hotdeal_tuum/data/services/token_storage_service.dart';

class AuthInterceptor extends InterceptorsWrapper {
  final TokenStorageService storage;
  final Dio dio;

  AuthInterceptor({required this.storage, required this.dio});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await storage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await storage.getRefreshToken();
        if (refreshToken == null) {
          await storage.clearTokens();
          return handler.next(err);
        }

        // Use the injected dio instance for the refresh token call
        final response = await dio.post(
          '/auth/refresh',
          data: {'refreshToken': refreshToken},
        );

        if (response.statusCode == 200) {
          final newAccessToken = response.data['accessToken'];
          final newRefreshToken = response.data['refreshToken'];

          await storage.saveTokens(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
            rememberMe: await storage.isRememberMeEnabled(),
          );

          // Retry the original request with the new token
          final originalRequest = err.requestOptions;
          originalRequest.headers['Authorization'] = 'Bearer $newAccessToken';
          
          final retriedResponse = await dio.fetch(originalRequest);
          return handler.resolve(retriedResponse);
        }
      } catch (e) {
        await storage.clearTokens();
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}

