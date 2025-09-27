import 'package:flutter/material.dart';

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromARGB(255, 3, 9, 120),
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
);
