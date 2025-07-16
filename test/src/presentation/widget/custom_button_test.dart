import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_button.dart';

void main() {
  group('CustomButton', () {
    testWidgets('renders correctly with text', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              onPressed: () {},
              text: 'Login',
            ),
          ),
        ),
      );

      // Act
      final textFinder = find.text('Login');

      // Assert
      expect(textFinder, findsOneWidget);
    });

    testWidgets('shows CircularProgressIndicator when isLoading is true',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              onPressed: () {},
              text: 'Login',
              isLoading: true,
            ),
          ),
        ),
      );

      // Act
      final progressIndicatorFinder = find.byType(CircularProgressIndicator);
      final textFinder = find.text('Login');

      // Assert
      expect(progressIndicatorFinder, findsOneWidget);
      expect(textFinder, findsNothing);
    });

    testWidgets('onPressed is disabled when isLoading is true',
        (WidgetTester tester) async {
      // Arrange
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              onPressed: () => pressed = true,
              text: 'Login',
              isLoading: true,
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(CustomButton));
      await tester.pump();

      // Assert
      expect(pressed, isFalse);
    });
  });
}
