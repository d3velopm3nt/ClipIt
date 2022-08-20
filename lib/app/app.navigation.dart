import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/clip_viewer.dart';

import '../ui/settings_view.dart';

class Navigation {
  static GlobalKey<NavigatorState> mainAppNav = GlobalKey();

  static String previousRoute = "";
  static String currentRoute = "";

  static navigationRoutes(String? name, [Object? args]) {
    Widget page;
    previousRoute = (previousRoute == "" ? name : currentRoute)!;
    currentRoute = name!;

    switch (name) {
      case Routes.settings:
        page = const SettingsPage();
        break;
      case Routes.home:
      default:
        page = const MyHomePage();
        break;
    }

    return PageRouteBuilder<dynamic>(
        pageBuilder: (_, __, ___) => page,
        settings: RouteSettings(arguments: args),
        transitionDuration: const Duration(seconds: 0));
  }

    static previousPage() {
    mainAppNav.currentState!.pushReplacementNamed(previousRoute);
  }

  static navigateToRoute(String route, {Object? args}) {
    mainAppNav.currentState!.pushNamed(route, arguments: args);
  }
}

class Routes {
  static const String home = "/";
  static const String settings = "/settings";
}

