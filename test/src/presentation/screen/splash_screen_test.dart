import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/core/config.dart';
import 'package:hotdeal_with_hono/src/infrastructure/service/token_storage_service.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/keyword_screen.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/login_screen.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/splash_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_screen_test.mocks.dart';

@GenerateMocks([TokenStorageService])
void main() {
  late MockTokenStorageService mockTokenStorageService;

  setUp(() {
    mockTokenStorageService = MockTokenStorageService();
  });

  testWidgets('SplashScreen navigates to LoginScreen when no token is found',
      (WidgetTester tester) async {
    // Arrange
    when(mockTokenStorageService.getAccessToken()).thenAnswer((_) async => null);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenStorageServiceProvider.overrideWithValue(mockTokenStorageService),
          appConfigProvider.overrideWithValue(AppConfig(baseUrl: 'http://mock.api')),
        ],
        child: const MaterialApp(
          home: SplashScreen(),
        ),
      ),
    );

    // Act
    await tester.pumpAndSettle(); // Wait for navigation to complete

    // Assert
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(KeywordScreen), findsNothing);
  });

  testWidgets('SplashScreen navigates to KeywordScreen when token is found',
      (WidgetTester tester) async {
    // Arrange
    when(mockTokenStorageService.getAccessToken()).thenAnswer((_) async => 'fake_token');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenStorageServiceProvider.overrideWithValue(mockTokenStorageService),
          appConfigProvider.overrideWithValue(AppConfig(baseUrl: 'http://mock.api')),
        ],
        child: const MaterialApp(
          home: SplashScreen(),
        ),
      ),
    );

    // Act
    await tester.pumpAndSettle(); // Wait for navigation to complete

    // Assert
    expect(find.byType(KeywordScreen), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);
  });
}
