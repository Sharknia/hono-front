import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/presentation/widget/custom_alert_dialog.dart';

void main() {
  group('CustomAlertDialog', () {
    testWidgets('renders correctly for success type', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showCustomDialog(
                  context: context,
                  dialogType: DialogType.success,
                  title: 'Success',
                  content: 'Operation was successful.',
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Success'), findsOneWidget);
      expect(find.text('Operation was successful.'), findsOneWidget);
      expect(find.text('Cancel'), findsNothing);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('renders correctly for confirmation type', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showCustomDialog(
                  context: context,
                  dialogType: DialogType.confirmation,
                  title: 'Confirm',
                  content: 'Are you sure?',
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Confirm'), findsOneWidget);
      expect(find.text('Are you sure?'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });
  });
}
