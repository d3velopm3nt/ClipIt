import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../theme/theme_changer.dart';
import '../../ui/widgets/shared/color_selector.dart';
import '../../ui/widgets/shared/title_desc_widget.dart';
import '../services/settings_service.dart';

class ThemeSettings extends SettingsSection {
  ThemeSettings({Key? key}) : super(key: key, tiles: []);
  late ThemeChanger themeProvider;
  late SettingsService settingService;
  @override
  SettingsSection build(BuildContext context) {
    themeProvider = Provider.of<ThemeChanger>(context);
    settingService = Provider.of<SettingsService>(context);
    return SettingsSection(title: const Text('Theme Settings'), tiles: [
      SettingsTile.switchTile(
        title: const TitleDesc(
            title: 'Dark Mode',
            description: 'Switch Between Dark Mode and Light Mode'),
        leading: const Icon(Icons.mode_night),
        initialValue: themeProvider.darkMode,
        onToggle: (value) {
          updateDarkMode(value);
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
              changePrimaryColor(color);
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
              changeSecondColor(color);
            },
          ),
          onPressed: (context) => {}),
    ]);
  }

  Future<void> updateDarkMode(bool enabled) async {
    themeProvider.setDarkMode(enabled);
    settingService.appSettings.darkMode = enabled;
    await settingService.saveSettings();
  }

  Future<void> changePrimaryColor(Color color) async {
    themeProvider.setPrimaryColor(color);
    settingService.appSettings.primaryColor = color.value;
    await settingService.saveSettings();
  }

  Future<void> changeSecondColor(Color color) async {
    themeProvider.setSecondColor(color);
    settingService.appSettings.secondaryColor = color.value;
    await settingService.saveSettings();
  }
}
