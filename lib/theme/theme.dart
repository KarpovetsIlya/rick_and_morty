import 'package:flutter/material.dart';

const primaryColor = Colors.indigo;

final themeData = ThemeData(
  useMaterial3: true,
);

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  textTheme: textTheme,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  textTheme: textTheme,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  ),
);

final textTheme = TextTheme(
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  headlineLarge: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  ),
);
