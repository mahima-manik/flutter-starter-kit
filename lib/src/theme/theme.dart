import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey.shade400,
  primarySwatch: Colors.grey,
  primaryColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade400,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((_) => Colors.grey.shade300),
      textStyle: WidgetStateProperty.resolveWith((_) => const TextStyle(color: Colors.white)),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade300,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
    headlineLarge: TextStyle(color: Colors.black),
    headlineMedium: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black),
  ),
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade400,
    primary: Colors.grey.shade300,
    secondary: Colors.grey.shade200,
    onSurface: Colors.black,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey.shade900,
  primarySwatch: Colors.grey,
  primaryColor: Colors.grey.shade800,
  highlightColor: Colors.grey.shade900,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade800,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((_) => Colors.grey.shade800),
      textStyle: WidgetStateProperty.resolveWith((_) => const TextStyle(color: Colors.white)),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
  ),
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    onSurface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
);
