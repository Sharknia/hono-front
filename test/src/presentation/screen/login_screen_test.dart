import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/login_screen.dart';

void main() {
  testWidgets('LoginScreen has an email field, a password field, and a login button',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(const ProviderScope(
      child: MaterialApp(home: LoginScreen()),
    ));

    // Act
    final emailField = find.byKey(const ValueKey('emailField'));
    final passwordField = find.byKey(const ValueKey('passwordField'));
    final loginButton = find.byKey(const ValueKey('loginButton'));

    // Assert
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);
  });
}
