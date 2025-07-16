import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/infrastructure/service/token_storage_service.dart';

void main() {
  group('TokenStorageService', () {
    late TokenStorageService tokenStorageService;
    final Map<String, String> mockValues = {};

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      // Mock the storage for testing
      const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == 'read') {
          return mockValues[methodCall.arguments['key']];
        }
        if (methodCall.method == 'write') {
          mockValues[methodCall.arguments['key']] = methodCall.arguments['value'];
          return null;
        }
        if (methodCall.method == 'delete') {
          mockValues.remove(methodCall.arguments['key']);
          return null;
        }
        return null;
      });
      tokenStorageService = TokenStorageService();
    });

    tearDown(() {
      mockValues.clear();
    });

    test('saveTokens saves access and refresh tokens', () async {
      // Arrange
      const accessToken = 'test_access_token';
      const refreshToken = 'test_refresh_token';

      // Act
      await tokenStorageService.saveTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      // Assert
      expect(mockValues['accessToken'], accessToken);
      expect(mockValues['refreshToken'], refreshToken);
    });

    test('getAccessToken returns the saved access token', () async {
      // Arrange
      const accessToken = 'test_access_token';
      mockValues['accessToken'] = accessToken;

      // Act
      final result = await tokenStorageService.getAccessToken();

      // Assert
      expect(result, accessToken);
    });

    test('deleteAllTokens removes both tokens', () async {
      // Arrange
      mockValues['accessToken'] = 'test_access_token';
      mockValues['refreshToken'] = 'test_refresh_token';

      // Act
      await tokenStorageService.deleteAllTokens();

      // Assert
      expect(mockValues.containsKey('accessToken'), isFalse);
      expect(mockValues.containsKey('refreshToken'), isFalse);
    });
  });
}
