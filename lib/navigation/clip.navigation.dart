import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/views/clip/clip_collection_view.dart';
import 'package:flutter_my_clipboard/ui/views/saved/clip_favorite_view.dart';
import '../ui/views/saved/hotkeys_view.dart';
import '../models/clipitem.model.dart';
import '../ui/views/clip/clip_tags_view.dart';
import '../ui/views/clip/clipboard_view.dart';
import '../ui/views/clip/tag_selection.view.dart';

class ClipNavigation {
  static final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

  static String previousRoute = "";
  static String currentRoute = ClipRoutes.clipboard;

  static navigationRoutes(String? name, [Object? args]) {
    Widget page;
    previousRoute = (previousRoute == "" ? name : currentRoute)!;
    currentRoute = name!;

    switch (name) {
      case ClipRoutes.dates:
        page = const ClipCollectionView();
        break;
      case SavedRoutes.favorites:
        page = const ClipFavoriteView();
        break;
      case SavedRoutes.hotkeys:
        page = const HotkeysView();
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
        transitionDuration: const Duration(milliseconds: 200),
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
    nav.currentState!.popAndPushNamed(previousRoute);
  }

  static navigateToRoute(String route, {Object? args}) {
    if(route != currentRoute){
    nav.currentState!.pushReplacementNamed(route, arguments: args);
    }
  }
}

class ClipRoutes {
  static const String clipboard = "/board";
  static const String dates = "/calendar";
  static const String tags = "/tags";
  static const String tagSelector = '/tag-selector';
}

class SavedRoutes {
  static const String favorites = "/saved/favorites";
  static const String groups = "/saved/groups";
  static const String hotkeys = "/saved/hotkeys";
  static const String chain = "/saved/chain";
}
