import 'package:flutter/material.dart';

final theme = ThemeData(
  appBarTheme: const AppBarTheme(
    toolbarHeight: 72,
    elevation: 0,
    centerTitle: true,
  ),
  // primaryColorDark: const Color(0xFF0097A7),
  // primaryColorLight: const Color(0xFFB2EBF2),
  // colorScheme: const ColorScheme.light(secondary: Color(0xFF009688)),
  scaffoldBackgroundColor: const Color(0xFFFDFAF6),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color(0xFF064420),
  ),
  // inputDecorationTheme: InputDecorationTheme(
  // border: OutlineInputBorder(
  // borderRadius: BorderRadius.circular(8),
  // ),
  // ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size.fromHeight(64),
      primary: const Color(0xFF064420),
      textStyle: const TextStyle(
        fontSize: 20,
      ),
    ),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
    headline3: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
    headline4: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFFFDFAF6),
    ),
    headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(
      fontSize: 20.0,
    ),
    // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
  colorScheme: const ColorScheme.light().copyWith(
    primary: const Color(0xFF064420),
    secondary: const Color(0xFFE4EFE7),
    onPrimary: const Color(0xFFFDFAF6),
    onSecondary: const Color(0xFFFAF1E6),
  ),
);
