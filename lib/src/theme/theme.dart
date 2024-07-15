import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey.shade200, // Light grey background
  primarySwatch: Colors.grey,
  primaryColor: Colors.grey.shade600, // Darker grey for primary elements
  highlightColor: const Color(0xFFD471D4), // Pink highlight color
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStateProperty.resolveWith((_) => Colors.grey.shade300),
      foregroundColor: WidgetStateProperty.resolveWith((_) => Colors.black),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade300, // Light grey for the app bar
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(
        color: Colors.black87), // Slightly muted black for medium text
    bodySmall:
        TextStyle(color: Colors.black54), // More muted black for small text
    headlineLarge: TextStyle(
        color: Colors.black), // Black for headlines for better readability
    headlineMedium: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black),
  ),
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300, // Light grey for surfaces
    primary: Colors.grey.shade600, // Darker grey for primary
    secondary: const Color(0xFF71B9D4), // Blue for secondary
    onSurface: Colors.black,
    onPrimary: Colors.white, // White on primary for better readability
    onSecondary: Colors.black,
  ),
);


ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey.shade900, // Dark grey background
  primarySwatch: Colors.grey,
  primaryColor: Colors.grey.shade800, // Darker grey for primary elements
  highlightColor: const Color(0xFFD471D4), // Pink highlight color
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade800, // Dark grey for the app bar
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStateProperty.resolveWith((_) => Colors.grey.shade800),
      foregroundColor: WidgetStateProperty.resolveWith((_) => Colors.white),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(
        color: Colors.white70), // Slightly muted white for medium text
    bodySmall:
        TextStyle(color: Colors.white60), // More muted white for small text
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
  ),
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade800, // Dark grey for surfaces
    primary: Colors.grey.shade800, // Darker grey for primary
    secondary: const Color(0xFF34C6D6), // Blue for secondary
    onSurface: Colors.white,
    onPrimary: Colors.white, // White on primary for better readability
    onSecondary: Colors.black,
  ),
);
