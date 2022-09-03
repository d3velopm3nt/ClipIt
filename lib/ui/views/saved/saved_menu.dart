import 'package:flutter/material.dart';
import '../../../navigation/clip.navigation.dart';
import '../../widgets/shared/app_menu_item.dart';

class SavedMenu extends StatefulWidget {
 const SavedMenu({Key? key}) : super(key: key);

  @override
  State<SavedMenu> createState() => _SavedMenuState();
}

class _SavedMenuState extends State<SavedMenu> {
  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Row(
           crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        AppMenuItem(
            route: SavedRoutes.favorites,
          icon: Icons.favorite, onPressed: () {
          ClipNavigation.navigateToRoute(SavedRoutes.favorites);
        }),
        // AppMenuItem(icon: Icons.double_arrow_sharp, onPressed: () {}),
        AppMenuItem(
            route: SavedRoutes.hotkeys,
            icon: Icons.local_fire_department,
            onPressed: () {
              ClipNavigation.navigateToRoute(SavedRoutes.hotkeys);
            }),
        AppMenuItem(
            route: SavedRoutes.groups,
          icon: Icons.space_dashboard, onPressed: () {}),
      ]),
    );
  }
}
