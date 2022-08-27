import 'package:flutter/material.dart';

const Color primaryLightColor = Color.fromARGB(255, 159, 33, 243);
const Color primaryDarkColor = Colors.red;

ThemeData darkTheme = ThemeData(
    secondaryHeaderColor: Colors.amber,
    brightness: Brightness.dark,
    primaryColor: primaryDarkColor,
    appBarTheme: const AppBarTheme(backgroundColor: primaryDarkColor));

ThemeData lightTheme = ThemeData(
    secondaryHeaderColor: Colors.greenAccent[400],
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(backgroundColor: primaryLightColor),
    primaryColor: primaryLightColor);
