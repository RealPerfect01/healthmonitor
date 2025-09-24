import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = const ColorScheme.light(
      primary: Colors.deepPurple,
      secondary: Colors.teal,
      error: Colors.red,
      surface: Colors.white,
      onPrimary: Colors.white,
    );
    return ThemeData(
      primaryColor: colorScheme.primary,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: _textTheme(Colors.black, Colors.grey),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.black.withAlpha(25),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        color: colorScheme.surface,
      ),
      buttonTheme: _buttonTheme(),
      elevatedButtonTheme: _elevatedButtonTheme(colorScheme),
      appBarTheme: _appBarTheme(colorScheme.primary, Colors.white),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = const ColorScheme.dark(
      primary: Colors.deepPurple,
      secondary: Colors.teal,
      error: Colors.red,
      surface: Color(0xFF121212),
      onPrimary: Colors.white,
    );
    return ThemeData(
      primaryColor: colorScheme.primary,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: _textTheme(Colors.white, Colors.grey),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.black.withAlpha(51),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        color: colorScheme.surface,
      ),
      buttonTheme: _buttonTheme(),
      elevatedButtonTheme: _elevatedButtonTheme(colorScheme),
      appBarTheme: _appBarTheme(colorScheme.surface, Colors.white),
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

  static ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
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
