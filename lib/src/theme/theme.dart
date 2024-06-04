import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey.shade200,  // Lighter background for better contrast
  primarySwatch: Colors.grey,
  primaryColor: Colors.grey.shade600,  // Darker grey for primary elements
  highlightColor: Colors.grey.shade300,  // Lighter highlight for subtle differentiation
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((_) => Colors.grey.shade300),
      foregroundColor: WidgetStateProperty.resolveWith((_) => Colors.black),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade300,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
    headlineLarge: TextStyle(color: Colors.white),  // White for headlines for better readability
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
  ),
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,  // Light surface for subtle contrast
    primary: Colors.grey.shade600,  // Darker primary for more impact
    secondary: Colors.grey.shade400,  // Secondary color that is between primary and background
    onSurface: Colors.black,
    onPrimary: Colors.white,  // White on primary for better readability
    onSecondary: Colors.black,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey.shade900,  // Dark background for deep contrast
  primarySwatch: Colors.grey,
  primaryColor: Colors.grey.shade800,  // Dark grey for primary elements
  highlightColor: Colors.grey.shade700,  // Slightly lighter grey for highlights
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade800,  // Consistent with primary color
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((_) => Colors.grey.shade800),
      foregroundColor: WidgetStateProperty.resolveWith((_) => Colors.white),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),  // White for headlines for better readability
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
  ),
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade800,  // Dark surface for a unified look
    primary: Colors.grey.shade800,  // Dark primary for a strong presence
    secondary: Colors.grey.shade600,  // Lighter secondary for subtle differentiation
    onSurface: Colors.white,
    onPrimary: Colors.white,  // White on primary for better readability
    onSecondary: Colors.white,
  ),
);
