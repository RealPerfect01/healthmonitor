import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.alert,
        surface: AppColors.backgroundLight,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: _textTheme(AppColors.textPrimary, AppColors.textSecondary),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.black.withAlpha(25),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        color: AppColors.backgroundLight,
      ),
      buttonTheme: _buttonTheme(),
      elevatedButtonTheme: _elevatedButtonTheme(),
      appBarTheme: _appBarTheme(AppColors.primary, Colors.white),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.alert,
        surface: AppColors.backgroundDark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: _textTheme(AppColors.textOnDark, AppColors.textSecondary),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.black.withAlpha(51),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        color: AppColors.backgroundDark,
      ),
      buttonTheme: _buttonTheme(),
      elevatedButtonTheme: _elevatedButtonTheme(),
      appBarTheme: _appBarTheme(AppColors.backgroundDark, AppColors.textOnDark),
    );
  }

  static TextTheme _textTheme(Color primaryColor, Color secondaryColor) {
    return GoogleFonts.robotoTextTheme(
      TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: primaryColor),
        displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
        displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
        bodyLarge: TextStyle(fontSize: 16, color: primaryColor),
        bodyMedium: TextStyle(fontSize: 14, color: secondaryColor),
      ),
    );
  }

  static ButtonThemeData _buttonTheme() {
    return ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  static AppBarTheme _appBarTheme(Color backgroundColor, Color foregroundColor) {
    return AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
