import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/login_screen.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_button.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_text_field.dart';

void main() {
  testWidgets('LoginScreen has custom text fields and a custom button',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(const ProviderScope(
      child: MaterialApp(home: LoginScreen()),
    ));

    // Act
    final emailField = find.byType(CustomTextField).first;
    final passwordField = find.byType(CustomTextField).last;
    final loginButton = find.byType(CustomButton);

    // Assert
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == 'Email'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == 'Password'), findsOneWidget);
    expect(loginButton, findsOneWidget);
  });
}
