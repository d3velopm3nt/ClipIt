import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/views/clip_collection_view.dart';
import 'package:flutter_my_clipboard/ui/views/saved/saved_clips_view.dart';
import '../models/clipitem.model.dart';
import '../ui/views/clip_tags_view.dart';
import '../ui/views/clipboard_view.dart';
import '../ui/views/tag_selection.view.dart';

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
      case ClipRoutes.saved:
        page = SavedView();
        break;
      case ClipRoutes.tags:
        page = const ClipTagsView();
        break;
      case ClipRoutes.tagSelector:
        page = TagSelectorView(item: args as ClipItem);
        break;
      case ClipRoutes.clipboard:
      default:
        page = ClipboardView();
        break;
    }

    return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        settings: RouteSettings(arguments: args),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeIn;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
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
  static const String tagSelector = '/tag-selector';
  static const String saved = "/saved";
}
