import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../navigation/clip.navigation.dart';
import '../../../navigation/navigation_manager.dart';
import '../../widgets/shared/app_menu_item.dart';

class ClipMenu extends StatefulWidget {
  const ClipMenu({Key? key}) : super(key: key);

  @override
  State<ClipMenu> createState() => _ClipMenuState();
}

class _ClipMenuState extends State<ClipMenu> {
  @override
  Widget build(BuildContext context) {
    final navigation = Provider.of<NavigationManager>(context);
    return Expanded(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppMenuItem(
              route: ClipRoutes.clipboard,
                icon: Icons.search,
                label: "Search",
                onPressed: () {
                  navigation.pageLoading(true);
                  ClipNavigation.navigateToRoute(ClipRoutes.clipboard);
                }),
            AppMenuItem(
              route: ClipRoutes.calendar,
                icon: Icons.calendar_month,
                label: "Calendar",
                onPressed: () {
                   navigation.pageLoading(true);
                  ClipNavigation.navigateToRoute(ClipRoutes.calendar);
                }),
            AppMenuItem(
              route: ClipRoutes.tags, 
                icon: Icons.local_offer,
                label: "Tags",
                onPressed: () {
                   navigation.pageLoading(true);
                  ClipNavigation.navigateToRoute(ClipRoutes.tags);
                }),
            AppMenuItem(
              route: SavedRoutes.favorites,
                icon: Icons.bookmark,
                label: "Saved",
                onPressed: () {
                  navigation.changeNav(NavRoutes.saved);
                  ClipNavigation.navigateToRoute(SavedRoutes.favorites);
                }),
          ]),
    );
  }
}
