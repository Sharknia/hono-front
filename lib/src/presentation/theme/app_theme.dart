import 'package:flutter/material.dart';

// 1. 색상 팔레트 (Color Palette)
class AppColors {
  static const Color primary = Color(0xFF2C3E50);
  static const Color secondary = Color(0xFF34495E);
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color error = Color(0xFFE74C3C);
  static const Color white = Color(0xFFFFFFFF);
}

// 2. 간격 시스템 (Spacing System)
class AppSpacing {
  static const double p4 = 4.0;
  static const double p8 = 8.0;
  static const double p12 = 12.0;
  static const double p16 = 16.0;
  static const double p24 = 24.0;
  static const double p32 = 32.0;
}

// 3. 타이포그래피 (Typography)
class AppTypography {
  static const TextTheme textTheme = TextTheme(
    // 큰 제목 (예: 화면 타이틀)
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    // 중간 제목
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    // 본문 텍스트
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    ),
    // 버튼 텍스트
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
    // 보조 텍스트
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.textSecondary,
    ),
  );
}

// 4. 앱 테마 (AppTheme)
final appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    background: AppColors.background,
    surface: AppColors.surface,
    error: AppColors.error,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onBackground: AppColors.textPrimary,
    onSurface: AppColors.textPrimary,
    onError: AppColors.white,
  ),
  textTheme: AppTypography.textTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.surface,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: AppTypography.textTheme.headlineMedium?.copyWith(fontSize: 20),
    iconTheme: const IconThemeData(color: AppColors.primary),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.p8),
      borderSide: const BorderSide(color: AppColors.textSecondary, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.p8),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    labelStyle: AppTypography.textTheme.bodyMedium,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      textStyle: AppTypography.textTheme.labelLarge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.p8),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.p12,
        horizontal: AppSpacing.p24,
      ),
    ),
  ),
);
