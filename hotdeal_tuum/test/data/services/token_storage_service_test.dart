import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hotdeal_tuum/data/services/token_storage_service.dart';

void main() {
  group('TokenStorageService', () {
    late TokenStorageService tokenStorageService;

    // Mock initial values for flutter_secure_storage
    Map<String, String> mockInitialValues = {};

    setUp(() {
      // Set up mock values before each test
      mockInitialValues = {}; // Reset the map for each test
      FlutterSecureStorage.setMockInitialValues(mockInitialValues);
      tokenStorageService = TokenStorageService();
    });

    tearDown(() async {
      // Clear storage after each test
      await tokenStorageService.clearTokens();
    });

    group('when rememberMe is true', () {
      test('saves and retrieves tokens from secure storage', () async {
        // Arrange
        const accessToken = 'test_access_token';
        const refreshToken = 'test_refresh_token';

        // Act
        await tokenStorageService.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
          rememberMe: true,
        );
        final retrievedAccessToken = await tokenStorageService.getAccessToken();
        final retrievedRefreshToken = await tokenStorageService.getRefreshToken();
        final rememberMeEnabled = await tokenStorageService.isRememberMeEnabled();

        // Assert
        expect(retrievedAccessToken, accessToken);
        expect(retrievedRefreshToken, refreshToken);
        expect(rememberMeEnabled, isTrue);
      });

      test('clearTokens removes tokens from secure storage', () async {
        // Arrange
        await tokenStorageService.saveTokens(
          accessToken: 'token',
          refreshToken: 'token',
          rememberMe: true,
        );

        // Act
        await tokenStorageService.clearTokens();
        final accessToken = await tokenStorageService.getAccessToken();
        final refreshToken = await tokenStorageService.getRefreshToken();
        final rememberMe = await tokenStorageService.isRememberMeEnabled();

        // Assert
        expect(accessToken, isNull);
        expect(refreshToken, isNull);
        expect(rememberMe, isFalse);
      });
    });

    group('when rememberMe is false', () {
      test('saves and retrieves tokens from in-memory storage', () async {
        // Arrange
        const accessToken = 'session_access_token';
        const refreshToken = 'session_refresh_token';

        // Act
        await tokenStorageService.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
          rememberMe: false,
        );
        final retrievedAccessToken = await tokenStorageService.getAccessToken();
        final retrievedRefreshToken = await tokenStorageService.getRefreshToken();
        final rememberMeEnabled = await tokenStorageService.isRememberMeEnabled();

        // Assert
        expect(retrievedAccessToken, accessToken);
        expect(retrievedRefreshToken, refreshToken);
        expect(rememberMeEnabled, isFalse);
      });

      test('tokens are not persisted in secure storage', () async {
        // Arrange
        await tokenStorageService.saveTokens(
          accessToken: 'session_access_token',
          refreshToken: 'session_refresh_token',
          rememberMe: false,
        );

        // Act: Create a new instance to simulate app restart
        final newService = TokenStorageService();
        final accessToken = await newService.getAccessToken();
        final refreshToken = await newService.getRefreshToken();

        // Assert
        expect(accessToken, isNull);
        expect(refreshToken, isNull);
      });

      test('clearTokens removes tokens from in-memory storage', () async {
        // Arrange
        await tokenStorageService.saveTokens(
          accessToken: 'session_token',
          refreshToken: 'session_token',
          rememberMe: false,
        );

        // Act
        await tokenStorageService.clearTokens();
        final accessToken = await tokenStorageService.getAccessToken();
        final refreshToken = await tokenStorageService.getRefreshToken();

        // Assert
        expect(accessToken, isNull);
        expect(refreshToken, isNull);
      });
    });
  });
}
