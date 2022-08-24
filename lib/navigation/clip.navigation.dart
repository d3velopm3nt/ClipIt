import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/clip_collection_view.dart';
import '../ui/clip_favorite_view.dart';
import '../ui/clipboard_view.dart';

class ClipNavigation {
  static GlobalKey<NavigatorState> nav = GlobalKey();

  static String previousRoute = "";
  static String currentRoute = "";

  static navigationRoutes(String? name, [Object? args]) {
    Widget page;
    previousRoute = (previousRoute == "" ? name : currentRoute)!;
    currentRoute = name!;

    switch (name) {
      case ClipRoutes.dates:
        page = const ClipCollectionView();
        break;
      case ClipRoutes.favorites:
        page = const ClipFavoriteView();
        break;
      case ClipRoutes.clipboard:
      default:
        page = ClipboardView();
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

class ClipRoutes {
  static const String clipboard = "/board";
  static const String dates = "/calendar";
  static const String tags = "/tags";
  static const String favorites = "/favorites";
}
