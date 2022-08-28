import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../theme/theme_changer.dart';
import '../../ui/widgets/shared/color_selector.dart';
import '../../ui/widgets/shared/title_desc_widget.dart';

class ThemeSettings extends SettingsSection {
  ThemeSettings({Key? key}) : super(key: key, tiles: []);

  @override
  SettingsSection build(BuildContext context) {
    var themeProvider = Provider.of<ThemeChanger>(context);
    return SettingsSection(title: const Text('Theme Settings'), tiles: [
      SettingsTile.switchTile(
        title: const TitleDesc(
            title: 'Dark Mode',
            description: 'Switch Between Dark Mode and Light Mode'),
        leading: const Icon(Icons.mode_night),
        initialValue: themeProvider.darkMode,
        onToggle: (value) {
          themeProvider.setDarkMode(value);
        },
        onPressed: (context) => {},
      ),
      SettingsTile.switchTile(
          onToggle: (value) => {},
          initialValue: null,
          leading: const Icon(Icons.format_paint_sharp),
          title: const Text('Main Color'),
          trailing: ColorSelector(
            color: themeProvider.primaryColor,
            onColorChanged: (color) {
              themeProvider.setPrimaryColor(color);
            },
          ),
          onPressed: (context) => {}),
          SettingsTile.switchTile(
          onToggle: (value) => {},
          initialValue: null,
          leading: const Icon(Icons.format_paint_sharp),
          title: const Text('Second Color'),
          trailing: ColorSelector(
            color: themeProvider.secondaryColor as Color,
            onColorChanged: (color) {
              themeProvider.setSecondColor(color);
            },
          ),
          onPressed: (context) => {}),
    ]);
  }
}
