import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_text_field.dart';

void main() {
  testWidgets('CustomTextField renders correctly with label and hint text',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomTextField(
            labelText: 'Email',
            hintText: 'Enter your email',
          ),
        ),
      ),
    );

    // Act
    final labelFinder = find.text('Email');
    final hintFinder = find.text('Enter your email');

    // Assert
    expect(labelFinder, findsOneWidget);
    expect(hintFinder, findsOneWidget);
  });
}
