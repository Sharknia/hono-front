import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/core/config.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/sign_up_screen.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_button.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_text_field.dart';

void main() {
  final mockConfig = AppConfig(baseUrl: 'http://mock.api');

  testWidgets('SignUpScreen has all required fields and initial button state is disabled',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(mockConfig),
        ],
        child: const MaterialApp(home: SignUpScreen()),
      ),
    );

    // Assert
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == '이메일'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == '닉네임'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == '비밀번호'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == '비밀번호 확인'), findsOneWidget);
    
    final checkButton = tester.widget<CustomButton>(find.byWidgetPredicate((widget) => widget is CustomButton && widget.text == '중복 확인'));
    expect(checkButton.onPressed, isNotNull);

    final signUpButton = tester.widget<CustomButton>(find.byWidgetPredicate((widget) => widget is CustomButton && widget.text == '가입하기'));
    expect(signUpButton.onPressed, isNull); // Initially disabled
  });

  testWidgets('Entering text into fields keeps the text', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(mockConfig),
        ],
        child: const MaterialApp(home: SignUpScreen()),
      ),
    );

    // Act
    await tester.enterText(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == '이메일'), 'test@example.com');
    await tester.enterText(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == '닉네임'), 'testnick');
    await tester.pump();

    // Assert
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('testnick'), findsOneWidget);
  });
}
