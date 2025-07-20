import 'package:flutter/material.dart';
import 'package:hotdeal_tuum/core/constants/colors.dart';
import 'package:hotdeal_tuum/core/constants/text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: kFontFamily,
      brightness: Brightness.light,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kScaffoldBackgroundColor,
      cardColor: kCardColor,
      hintColor: kDisabledColor,
      textTheme: kTextTheme,
      
      colorScheme: const ColorScheme.light(
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        surface: kBackgroundColor,
        error: kErrorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: kTextColor,
        onError: Colors.white,
        brightness: Brightness.light,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: kFontFamily,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      buttonTheme: const ButtonThemeData(
        buttonColor: kPrimaryColor,
        disabledColor: kDisabledColor,
        textTheme: ButtonTextTheme.primary,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontFamily: kFontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
      ),
    );
  }

  // If you want to support dark theme, you can define it here
  // static ThemeData get darkTheme { ... }
}
