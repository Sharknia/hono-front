import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/core/config.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/login_screen.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_button.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_text_field.dart';

void main() {
  testWidgets('LoginScreen has custom text fields and a custom button',
      (WidgetTester tester) async {
    // Arrange
    final mockConfig = AppConfig(baseUrl: 'http://mock.api');
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(mockConfig),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    // Assert
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == 'Email'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == 'Password'), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);
    expect(find.text("Don't have an account? Sign Up"), findsOneWidget);
  });
}
