import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/views/clip/clip_manager_view.dart';
import 'package:flutter_my_clipboard/ui/views/intro/intro_view.dart';

import '../ui/views/quick_view.dart';
import '../ui/views/settings_view.dart';

class AppNavigation {
  static final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

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
      case AppRoutes.quickSelect:
        page = const QuickView();
        break;
      case AppRoutes.intro:
        page = const IntroView();
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
    nav.currentState!.popAndPushNamed(previousRoute);
  }

  static navigateToRoute(String route, {Object? args}) {
    nav.currentState!.pushReplacementNamed(route, arguments: args);
  }
}

class AppRoutes {
  static const String home = "/";
  static const String intro = "/intro";
  static const String settings = "/settings";
  static const String quickSelect = "/quickselect";
}
