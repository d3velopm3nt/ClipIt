import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../navigation/clip.navigation.dart';
import '../../../navigation/navigation_manager.dart';
import '../../widgets/shared/app_menu_item.dart';

class SavedMenu extends StatefulWidget {
 const SavedMenu({Key? key}) : super(key: key);

  @override
  State<SavedMenu> createState() => _SavedMenuState();
}

class _SavedMenuState extends State<SavedMenu> {
  @override
  Widget build(BuildContext context) {
 final navigation = Provider.of<NavigationManager>(context);
    return Expanded(
      child: Row(
           crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        AppMenuItem(
            route: SavedRoutes.favorites,
            label: "Favorites",
          icon: Icons.favorite, onPressed: () {
               navigation.pageLoading(true);
          ClipNavigation.navigateToRoute(SavedRoutes.favorites);
        }),
        // AppMenuItem(icon: Icons.double_arrow_sharp, onPressed: () {}),
        AppMenuItem(
            route: SavedRoutes.hotkeys,
            label: "Hot keys",
            icon: Icons.local_fire_department,
            onPressed: () {
                 navigation.pageLoading(true);
              ClipNavigation.navigateToRoute(SavedRoutes.hotkeys);
            }),
        // AppMenuItem(
        //     route: SavedRoutes.groups,
        //     label: "Groups",
        //   icon: Icons.space_dashboard, onPressed: () {}),
      ]),
    );
  }
}
