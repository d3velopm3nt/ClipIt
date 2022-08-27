import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/views/clip_manager_view.dart';

import '../ui/views/settings_view.dart';

class AppNavigation {
  static GlobalKey<NavigatorState> nav = GlobalKey();

  static String previousRoute = "";
  static String currentRoute = "";

  static navigationRoutes(String? name, [Object? args]) {
    Widget page;
    previousRoute = (previousRoute == "" ? name : currentRoute)!;
    currentRoute = name!;

    switch (name) {
      case AppRoutes.settings:
        page = const SettingsPage();
        break;
      case AppRoutes.home:
      default:
        page = const ClipManagerPage();
        break;
    }

    return PageRouteBuilder<dynamic>(
        pageBuilder: (_, __, ___) => page,
        settings: RouteSettings(arguments: args),
        transitionDuration: const Duration(seconds: 0));
  }

    static previousPage() {
    nav.currentState!.pushReplacementNamed(previousRoute);
  }

  static navigateToRoute(String route, {Object? args}) {
    nav.currentState!.pushNamed(route, arguments: args);
  }
}

class AppRoutes {
  static const String home = "/";
  static const String settings = "/settings";
}

