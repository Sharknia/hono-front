import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotdeal_with_hono/src/presentation/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('appTheme is configured correctly', () {
      // Assert
      expect(appTheme, isA<ThemeData>());
      expect(appTheme.primaryColor, AppColors.primary);
      expect(appTheme.scaffoldBackgroundColor, AppColors.background);
    });

    test('TextTheme is configured correctly', () {
      // Assert
      expect(appTheme.textTheme.displayLarge?.color, AppColors.textPrimary);
      expect(appTheme.textTheme.bodyLarge?.fontSize, 16);
      expect(appTheme.textTheme.labelLarge?.color, AppColors.white);
    });

    test('ElevatedButtonTheme is configured correctly', () {
      final buttonTheme = appTheme.elevatedButtonTheme;
      // Assert
      expect(buttonTheme, isA<ElevatedButtonThemeData>());
      expect(buttonTheme.style?.backgroundColor?.resolve({}), AppColors.primary);
      expect(buttonTheme.style?.foregroundColor?.resolve({}), AppColors.white);
    });

    test('InputDecorationTheme is configured correctly', () {
      final inputTheme = appTheme.inputDecorationTheme;
      // Assert
      expect(inputTheme, isA<InputDecorationTheme>());
      expect(inputTheme.border, isA<OutlineInputBorder>());
      expect(inputTheme.focusedBorder, isA<OutlineInputBorder>());
      expect(inputTheme.focusedBorder?.borderSide.color, AppColors.primary);
    });
  });
}
