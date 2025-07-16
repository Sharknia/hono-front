import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/application/usecase/login_usecase.dart';
import 'package:hotdeal_with_hono/src/core/config.dart';
import 'package:hotdeal_with_hono/src/presentation/provider/auth_provider.dart';
import 'package:hotdeal_with_hono/src/presentation/screen/login_screen.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_button.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_text_field.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_screen_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  final mockConfig = AppConfig(baseUrl: 'http://mock.api');
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
  });

  testWidgets('LoginScreen has custom text fields and a custom button',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(mockConfig),
          loginUseCaseProvider.overrideWithValue(mockLoginUseCase),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    // Assert
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == '이메일'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is CustomTextField && widget.labelText == '비밀번호'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is CustomButton && widget.text == '로그인'), findsOneWidget);
    expect(find.text("계정이 없으신가요? 회원가입"), findsOneWidget);
  });
}

