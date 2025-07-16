// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/core/config.dart';
import 'package:hotdeal_with_hono/main.dart';

void main() {
  testWidgets('Renders LoginScreen and finds welcome message',
      (WidgetTester tester) async {
    // Arrange
    final mockConfig = AppConfig(baseUrl: 'http://mock.api');
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(mockConfig),
        ],
        child: const MyApp(),
      ),
    );

    // Verify that LoginScreen is rendered and find the welcome message.
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Welcome Back'), findsOneWidget);
  });
}

