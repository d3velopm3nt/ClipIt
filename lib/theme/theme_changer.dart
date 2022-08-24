import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'app.theme.dart';

class ThemeChanger extends ChangeNotifier {
  ThemeData _themeData;
  bool _darkMode = false;
  ThemeChanger(this._themeData);

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
}
