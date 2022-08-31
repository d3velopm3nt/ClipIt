import 'package:flutter/material.dart';

class NavigationManager extends ChangeNotifier {
  String _currentNavigation = NavRoutes.main;
  String get currentNavigation => _currentNavigation;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isNavMain = true;
  bool get isNavMain => _isNavMain;

  pageLoading(bool loaded) {
    _isLoading = loaded;
    notifyListeners();
  }

  changeNav(String nav) {
    _currentNavigation = nav;
    _isNavMain = nav == NavRoutes.main ? true : false;
    notifyListeners();
  }
}

class NavRoutes {
  static const String main = "main";
  static const String saved = "saved";
}
