import 'package:flutter/material.dart';

final lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.yellow.shade200,
    primary: Colors.blue,
    secondary: Colors.yellow,
    inversePrimary: Colors.grey.shade800
  )
);

final darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade600,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade100
  )
);