import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_tuum/data/api/interceptors/auth_interceptor.dart';
import 'package:hotdeal_tuum/data/services/token_storage_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_interceptor_test.mocks.dart';

// We mock Dio itself to verify interactions, not its internal behavior.
@GenerateMocks([TokenStorageService, Dio, ErrorInterceptorHandler])
void main() {
  late MockTokenStorageService mockTokenStorageService;
  late MockDio mockDio;
  late AuthInterceptor authInterceptor;

  setUp(() {
    mockTokenStorageService = MockTokenStorageService();
    mockDio = MockDio();
    authInterceptor = AuthInterceptor(storage: mockTokenStorageService, dio: mockDio);
  });

  group('AuthInterceptor', () {
    test('onRequest adds Authorization header when token exists', () async {
      when(mockTokenStorageService.getAccessToken()).thenAnswer((_) async => 'token');
      final options = RequestOptions(path: '/test');
      
      await authInterceptor.onRequest(options, RequestInterceptorHandler());

      expect(options.headers['Authorization'], 'Bearer token');
    });

    test('onError attempts to refresh token on 401', () async {
      // Arrange
      final error = DioException(
        requestOptions: RequestOptions(path: '/locked'),
        response: Response(statusCode: 401, requestOptions: RequestOptions(path: '/locked')),
      );
      final handler = MockErrorInterceptorHandler();
      const refreshToken = 'refresh';
      const newAccessToken = 'new_access';

      when(mockTokenStorageService.getRefreshToken()).thenAnswer((_) async => refreshToken);
      when(mockTokenStorageService.isRememberMeEnabled()).thenAnswer((_) async => true);
      when(mockTokenStorageService.saveTokens(accessToken: anyNamed('accessToken'), refreshToken: anyNamed('refreshToken'), rememberMe: anyNamed('rememberMe'))).thenAnswer((_) async {});
      
      // Mock the refresh call
      when(mockDio.post('/auth/refresh', data: {'refreshToken': refreshToken}))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: '/auth/refresh'),
              statusCode: 200,
              data: {'accessToken': newAccessToken, 'refreshToken': refreshToken}));
      
      // Mock the retry call
      when(mockDio.fetch(any)).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: '/locked'),
          statusCode: 200,
          data: 'Success'));

      // Act
      await authInterceptor.onError(error, handler);

      // Assert
      verify(mockTokenStorageService.getRefreshToken()).called(1);
      verify(mockDio.post('/auth/refresh', data: {'refreshToken': refreshToken})).called(1);
      verify(mockTokenStorageService.saveTokens(accessToken: newAccessToken, refreshToken: refreshToken, rememberMe: true)).called(1);
      verify(mockDio.fetch(error.requestOptions)).called(1); // Verify the retry call
      verify(handler.resolve(any)).called(1);
    });
  });
}