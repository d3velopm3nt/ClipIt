import 'package:flutter/material.dart';

import '../ui/views/clip_favorite_view.dart';

class SavedNavigation {
  static GlobalKey<NavigatorState> get nav => GlobalKey<NavigatorState>();

  static String previousRoute = "";
  static String currentRoute = "";

  static navigationRoutes(String? name, [Object? args]) {
    Widget page;
    previousRoute = (previousRoute == "" ? name : currentRoute)!;
    currentRoute = name!;

    switch (name) {
      case SavedRoutes.favorites:
      default:
        page = const ClipFavoriteView();
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

class SavedRoutes {
  static const String favorites = "/favorites";
  static const String groups = "/groups";
  static const String hotkeys = "/hotkeys";
  static const String chain = "/chain";
}
