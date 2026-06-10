import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

ThemeData buildAppTheme() {
  final baseTextTheme = TextTheme(
    displayLarge: GoogleFonts.playfairDisplay(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      height: 1.1,
    ),
    displayMedium: GoogleFonts.playfairDisplay(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      height: 1.12,
    ),
    headlineMedium: GoogleFonts.playfairDisplay(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: GoogleFonts.inter(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.inter(
      color: AppColors.textSecondary,
      height: 1.6,
    ),
    bodyMedium: GoogleFonts.inter(
      color: AppColors.textSecondary,
      height: 1.5,
    ),
    labelLarge: GoogleFonts.inter(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: baseTextTheme,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      surface: AppColors.surface,
      onPrimary: Colors.black,
      onSurface: AppColors.textPrimary,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        side: BorderSide(color: AppColors.divider),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w700),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w700),
      ),
    ),
  );
}
