import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    secondaryHeaderColor: Colors.amber,
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.red));

ThemeData lightTheme = ThemeData(
    secondaryHeaderColor: Colors.greenAccent[400],
    brightness: Brightness.light,
    primaryColor: Colors.blue);
