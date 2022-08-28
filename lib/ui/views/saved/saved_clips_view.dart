import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/navigation/saved.navigation.dart';
import 'package:flutter_my_clipboard/ui/views/saved/saved_menu.dart';

import '../../widgets/shared/app_menu_item.dart';

class SavedView extends StatefulWidget {
  SavedView({Key? key}) : super(key: key);

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      const Divider(),
      SavedMenu(),
       SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            width: MediaQuery.of(context).size.width,
            child: Navigator(
              key: SavedNavigation.nav,
              initialRoute: '/favorites',
              onGenerateRoute: (RouteSettings route) =>
                  SavedNavigation.navigationRoutes(route.name, route.arguments),
            ),
          )
    ]);
  }
}
