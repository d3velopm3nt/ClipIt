import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../theme/theme_changer.dart';
import '../../ui/widgets/title_desc_widget.dart';


class ThemeSetting extends SettingsTile {
  ThemeSetting({Key? key}) : super(key: key,title: const Text('Enable Dark Theme'));


  @override
  SettingsTile build(BuildContext context) {
    var themeProvider = Provider.of<ThemeChanger>(context);
    return SettingsTile.switchTile(
      title: const TitleDesc(title:'Dark Mode',description:'Switch Between Dark Mode and Light Mode'),
      leading: const Icon(Icons.format_paint),
      initialValue: themeProvider.darkMode,
      onToggle: (value) {
        themeProvider.setDarkMode(value);
      },
      onPressed: (context) => {},
    );
  }
}
