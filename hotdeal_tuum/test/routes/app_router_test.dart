import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_tuum/presentation/screens/home_screen.dart';
import 'package:hotdeal_tuum/presentation/screens/login_screen.dart';
import 'package:hotdeal_tuum/presentation/screens/splash_screen.dart';
import 'package:hotdeal_tuum/routes/app_router.dart';

void main() {
  group('AppRouter Navigation Tests', () {
    testWidgets('initial route should be SplashScreen', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
          ),
        ),
      );

      // Verify that SplashScreen is shown.
      expect(find.byType(SplashScreen), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
    });

    testWidgets('navigates to LoginScreen after splash delay', (WidgetTester tester) async {
      // Build our app
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
          ),
        ),
      );

      // SplashScreen is shown initially
      expect(find.byType(SplashScreen), findsOneWidget);

      // Fast-forward time by 2 seconds to trigger navigation
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle(); // Wait for animations to complete

      // Verify that LoginScreen is now shown.
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(SplashScreen), findsNothing);
    });

    testWidgets('navigates from LoginScreen to HomeScreen on button press', (WidgetTester tester) async {
      // Start at the login screen
      AppRouter.router.go('/login');

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify we are on the LoginScreen
      expect(find.byType(LoginScreen), findsOneWidget);

      // Find the button and tap it
      final button = find.widgetWithText(ElevatedButton, 'Go to Home');
      expect(button, findsOneWidget);
      await tester.tap(button);
      await tester.pumpAndSettle();

      // Verify that HomeScreen is now shown.
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
    });
  });
}
