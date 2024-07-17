import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF4A90E2),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xFFFF6B6B),
  ),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  cardColor: const Color(0xFFF5F5F5),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF333333)),
    bodyLarge: TextStyle(color: Color(0xFF333333)),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF4A90E2),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF4A90E2),
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFF5F5F5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(color: Colors.grey),
  ),
);
