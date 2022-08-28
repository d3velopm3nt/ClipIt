import 'package:flutter/material.dart';

import '../../widgets/shared/app_menu_item.dart';

class SavedMenu extends StatefulWidget {
  SavedMenu({Key? key}) : super(key: key);

  @override
  State<SavedMenu> createState() => _SavedMenuState();
}

class _SavedMenuState extends State<SavedMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      AppMenuItem(icon: Icons.favorite, onPressed: () {}),
        AppMenuItem(icon: Icons.double_arrow_sharp, onPressed: () {}),
       AppMenuItem(icon: Icons.local_fire_department, onPressed: () {}),
         AppMenuItem(icon: Icons.space_dashboard, onPressed: () {}),
    ]);
  }
}
