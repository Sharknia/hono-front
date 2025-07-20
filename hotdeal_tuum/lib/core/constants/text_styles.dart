import 'package:flutter/material.dart';
import 'package:hotdeal_tuum/core/constants/colors.dart';

const String kFontFamily = 'NotoSansKR';

const TextTheme kTextTheme = TextTheme(
  displayLarge: TextStyle(fontFamily: kFontFamily, fontSize: 57, fontWeight: FontWeight.w400, color: kTextColor),
  displayMedium: TextStyle(fontFamily: kFontFamily, fontSize: 45, fontWeight: FontWeight.w400, color: kTextColor),
  displaySmall: TextStyle(fontFamily: kFontFamily, fontSize: 36, fontWeight: FontWeight.w400, color: kTextColor),
  
  headlineLarge: TextStyle(fontFamily: kFontFamily, fontSize: 32, fontWeight: FontWeight.w400, color: kTextColor),
  headlineMedium: TextStyle(fontFamily: kFontFamily, fontSize: 28, fontWeight: FontWeight.w400, color: kTextColor),
  headlineSmall: TextStyle(fontFamily: kFontFamily, fontSize: 24, fontWeight: FontWeight.w400, color: kTextColor),

  titleLarge: TextStyle(fontFamily: kFontFamily, fontSize: 22, fontWeight: FontWeight.w500, color: kTextColor),
  titleMedium: TextStyle(fontFamily: kFontFamily, fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: kTextColor),
  titleSmall: TextStyle(fontFamily: kFontFamily, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: kTextColor),

  bodyLarge: TextStyle(fontFamily: kFontFamily, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, color: kTextColor),
  bodyMedium: TextStyle(fontFamily: kFontFamily, fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: kTextColor),
  bodySmall: TextStyle(fontFamily: kFontFamily, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, color: kTextColor),

  labelLarge: TextStyle(fontFamily: kFontFamily, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25, color: kTextColor),
  labelMedium: TextStyle(fontFamily: kFontFamily, fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.5, color: kTextColor),
  labelSmall: TextStyle(fontFamily: kFontFamily, fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5, color: kTextColor),
);
