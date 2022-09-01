import 'package:flutter/material.dart';

class ThemeChanger extends ChangeNotifier {
  late ThemeData _themeData = lightTheme;
  bool _darkMode = false;
  Color primaryColor = const Color.fromARGB(255, 159, 33, 243);
  //Color primaryDarkColor = Colors.red;
  Color? secondaryColor = Colors.greenAccent[400];
  ThemeChanger();

  ThemeData get getTheme => _themeData;

  get darkMode => _darkMode;
  void setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }

  void setDarkMode(bool enabled) {
    _darkMode = enabled;
    _themeData = _darkMode ? darkTheme : lightTheme;

    notifyListeners();
  }

  ThemeData get darkTheme {
    return ThemeData(
        secondaryHeaderColor: secondaryColor,
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        appBarTheme: AppBarTheme(backgroundColor: primaryColor));
  }

  ThemeData get lightTheme {
    return ThemeData(
        secondaryHeaderColor: secondaryColor,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(backgroundColor: primaryColor),
        primaryColor: primaryColor);
  }

  setPrimaryColor(Color color) {
    primaryColor = color;
    _themeData = _darkMode ? darkTheme : lightTheme;
    notifyListeners();
  }

  setSecondColor(Color color) {
    secondaryColor = color;
    _themeData = _darkMode ? darkTheme : lightTheme;
    notifyListeners();
  }
}

class HexToColor extends Color{
  HexToColor(final String code) : super(_hexToColor(code));
  static _hexToColor(String code) {
    return int.parse(code.substring(1, 7), radix: 16) + 0xFF000000;
  }
}
