import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle get _baseStyle => GoogleFonts.lexend(
        color: AppColors.textPrimary,
      );

  static TextStyle get displayLarge => _baseStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.02 * 32,
      );

  static TextStyle get headlineMedium => _baseStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get bodyLarge => _baseStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        height: 28 / 18,
      );

  static TextStyle get bodyMedium => _baseStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 24 / 16,
      );

  static TextStyle get labelLarge => _baseStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get labelMedium => _baseStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.01 * 14,
      );
}
