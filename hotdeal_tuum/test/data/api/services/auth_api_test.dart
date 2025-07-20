import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_tuum/data/api/services/auth_api.dart';
import 'package:hotdeal_tuum/data/models/login_response_model.dart';
import 'package:hotdeal_tuum/data/services/token_storage_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_api_test.mocks.dart';

@GenerateMocks([Dio, TokenStorageService])
void main() {
  late MockDio mockDio;
  late MockTokenStorageService mockTokenStorageService;
  late AuthApi authApi;

  setUp(() {
    mockDio = MockDio();
    mockTokenStorageService = MockTokenStorageService();
    authApi = AuthApi(dio: mockDio, tokenStorageService: mockTokenStorageService);
  });

  group('AuthApi login', () {
    test('should call login endpoint and save tokens on success', () async {
      // Arrange
      const email = 'test@test.com';
      const password = 'password';
      const rememberMe = true;
      final responsePayload = {
        'accessToken': 'new_access_token',
        'refreshToken': 'new_refresh_token',
      };
      final loginResponse = LoginResponseModel.fromJson(responsePayload);

      when(mockDio.post('/auth/login', data: {
        'email': email,
        'password': password,
      })).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: '/auth/login'),
            statusCode: 200,
            data: responsePayload,
          ));
      
      when(mockTokenStorageService.saveTokens(
        accessToken: loginResponse.accessToken,
        refreshToken: loginResponse.refreshToken,
        rememberMe: rememberMe,
      )).thenAnswer((_) async {});

      // Act
      await authApi.login(email: email, password: password, rememberMe: rememberMe);

      // Assert
      verify(mockDio.post('/auth/login', data: anyNamed('data'))).called(1);
      verify(mockTokenStorageService.saveTokens(
        accessToken: loginResponse.accessToken,
        refreshToken: loginResponse.refreshToken,
        rememberMe: rememberMe,
      )).called(1);
    });
  });
}
