import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/core/config.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/sign_up_screen.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_button.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_text_field.dart';

void main() {
  testWidgets('SignUpScreen has all required fields and initial button state is disabled',
      (WidgetTester tester) async {
    // Arrange
    final mockConfig = AppConfig(baseUrl: 'http://mock.api');
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(mockConfig),
        ],
        child: const MaterialApp(home: SignUpScreen()),
      ),
    );

    // Assert
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == 'Email'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == 'Nickname'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == 'Password'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == 'Confirm Password'), findsOneWidget);
    
    final checkButton = tester.widget<CustomButton>(find.byWidgetPredicate((widget) => widget is CustomButton && widget.text == 'Check'));
    expect(checkButton.onPressed, isNotNull);

    final signUpButton = tester.widget<CustomButton>(find.byWidgetPredicate((widget) => widget is CustomButton && widget.text == 'Sign Up'));
    expect(signUpButton.onPressed, isNull); // Initially disabled
  });
}
