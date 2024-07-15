import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor:
      Colors.blueGrey.shade50, // Very light blue-grey for background
  primarySwatch: Colors.blueGrey,
  primaryColor:
      Colors.blueGrey.shade600, // Darker blue-grey for primary elements
  highlightColor: Colors.blueGrey.shade200, // Light blue-grey for highlights
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStateProperty.resolveWith((_) => Colors.blueGrey.shade200),
      foregroundColor: WidgetStateProperty.resolveWith((_) => Colors.black),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor:
        Colors.blueGrey.shade100, // Light blue-grey for the app bar
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
    surface: Colors.blueGrey.shade100, // Light blue-grey for surfaces
    primary: Colors.blueGrey.shade600, // Darker blue-grey for primary
    secondary: Colors.teal.shade400, // Teal for secondary to add a pop of color
    onSurface: Colors.black,
    onPrimary: Colors.white, // White on primary for better readability
    onSecondary: Colors.black,
  ),
);


ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor:
      Colors.black, // Pure black for the background to enhance contrast
  primarySwatch: Colors.blueGrey,
  primaryColor: Colors.blueGrey.shade800, // Dark blue-grey for primary elements
  highlightColor:
      Colors.blueGrey.shade700, // Slightly lighter blue-grey for highlights
  appBarTheme: AppBarTheme(
    backgroundColor:
        Colors.blueGrey.shade900, // Darker blue-grey for the app bar
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStateProperty.resolveWith((_) => Colors.blueGrey.shade800),
      foregroundColor: WidgetStateProperty.resolveWith((_) => Colors.white),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(
        color: Colors.white70), // Slightly muted white for medium text
    bodySmall: TextStyle(
        color: Colors.white60), // Even more muted white for small text
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
  ),
  colorScheme: ColorScheme.dark(
    surface:
        Colors.blueGrey.shade800, // Dark surface to match the primary color
    primary: Colors.blueGrey.shade800, // Dark primary for a cohesive look
    secondary: Colors.teal.shade600, // Teal for secondary to add a pop of color
    onSurface: Colors.white,
    onPrimary: Colors.white, // White on primary for better readability
    onSecondary: Colors.black, // Black on secondary to ensure readability
  ),
);

