import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/infrastructure/service/token_storage_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'token_storage_service_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage, SharedPreferences])
void main() {
  group('TokenStorageService (Mobile)', () {
    late TokenStorageService tokenStorageService;
    late MockFlutterSecureStorage mockFlutterSecureStorage;

    setUp(() {
      mockFlutterSecureStorage = MockFlutterSecureStorage();
      tokenStorageService = TokenStorageService(
        secureStorage: mockFlutterSecureStorage,
        sharedPreferences: Future.value(MockSharedPreferences()), // Not used
      );
    });

    test('saveTokens calls FlutterSecureStorage.write', () async {
      // Arrange
      const accessToken = 'mobile_access_token';
      const refreshToken = 'mobile_refresh_token';
      when(mockFlutterSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')))
          .thenAnswer((_) async {});

      // Act
      await tokenStorageService.saveTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      // Assert
      verify(mockFlutterSecureStorage.write(key: 'accessToken', value: accessToken)).called(1);
      verify(mockFlutterSecureStorage.write(key: 'refreshToken', value: refreshToken)).called(1);
    });

    test('getAccessToken calls FlutterSecureStorage.read', () async {
      // Arrange
      const accessToken = 'mobile_access_token';
      when(mockFlutterSecureStorage.read(key: anyNamed('key'))).thenAnswer((_) async => accessToken);

      // Act
      final result = await tokenStorageService.getAccessToken();

      // Assert
      expect(result, accessToken);
      verify(mockFlutterSecureStorage.read(key: 'accessToken')).called(1);
    });

    test('deleteAllTokens calls FlutterSecureStorage.delete', () async {
      // Arrange
      when(mockFlutterSecureStorage.delete(key: anyNamed('key'))).thenAnswer((_) async {});

      // Act
      await tokenStorageService.deleteAllTokens();

      // Assert
      verify(mockFlutterSecureStorage.delete(key: 'accessToken')).called(1);
      verify(mockFlutterSecureStorage.delete(key: 'refreshToken')).called(1);
    });
  });
}
