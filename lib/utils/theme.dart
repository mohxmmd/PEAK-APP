import 'package:flutter/material.dart';

class AppTheme {
  // Define your primary color palette
  static const Color primaryColor = Color(0xFF90C764); // Primary blue
  static const Color accentColor = Color.fromARGB(255, 0, 0, 0); // Accent green
  static const Color bgColor = Color(0xFFF9F2E0);

  // Define the main theme
  static final ThemeData mainTheme = ThemeData(
    brightness: Brightness.light, // Set this based on the desired mode
    primaryColor: primaryColor,
    scaffoldBackgroundColor: bgColor,
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Urbanist', // Change to Urbanist font
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 255, 255, 255),
        fontFamily: 'Urbanist',
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 255, 255, 255),
        fontFamily: 'Urbanist',
      ),
      titleSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 255, 255, 255),
        fontFamily: 'Urbanist',
      ),
      headlineLarge: TextStyle(),
      headlineMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E252D),
        fontFamily: 'Urbanist', // Change to Urbanist font
      ),
      headlineSmall: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 255, 255, 255),
        fontFamily: 'Urbanist',
      ),
      displayLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E252D),
        fontFamily: 'Urbanist', // Change to Urbanist font
      ),
      displayMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E252D),
        fontFamily: 'Urbanist', // Change to Urbanist font
      ),
      displaySmall: TextStyle(),
      bodyLarge: TextStyle(
        fontSize: 14.0,
        color: Color(0xFF767775),
        fontWeight: FontWeight.w500,
        fontFamily: 'Urbanist', // Change to Urbanist font
        height: 1.7,
      ),
      bodyMedium: TextStyle(
        fontSize: 12.0,
        color: Color(0xFF78766B),
        fontWeight: FontWeight.w500,
        fontFamily: 'Urbanist', // Change to Urbanist font
        height: 1.7,
      ),
      bodySmall: TextStyle(),
      labelLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Urbanist', // Change to Urbanist font
      ),
      labelMedium: TextStyle(),
      labelSmall: TextStyle(),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: accentColor,
    ),
  );
}
