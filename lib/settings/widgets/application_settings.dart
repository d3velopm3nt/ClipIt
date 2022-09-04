import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/settings/services/settings_service.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../ui/widgets/shared/title_desc_widget.dart';

class ApplicationSettings extends SettingsSection {
  ApplicationSettings({Key? key}) : super(key: key, tiles: []);
  SettingsService settingProvider = SettingsService();
  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of<SettingsService>(context);

    return SettingsSection(title: const Text('Application Settings'), tiles: [
      SettingsTile.navigation(
          leading: const Icon(Icons.language),
          title: const Text('Language'),
          value: const Text('English'),
          onPressed: (context) => {}),
      SettingsTile.switchTile(
        title: const TitleDesc(
            title: 'Pin Clipboard',
            description: 'Keep the application always on top'),
        leading: const Icon(Icons.push_pin),
        initialValue: settingProvider.windowPinned.state,
        onToggle: (value) {
          savePinWindow(value);
        },
        onPressed: (context) => {},
      ),
      SettingsTile.switchTile(
        title: const TitleDesc(
            title: 'Window Mode',
            description: 'This will add the titlebar to the application'),
        leading: const Icon(Icons.window),
        initialValue: settingProvider.appSettings.windowMode,
        onToggle: (value) {
         

        },
        onPressed: (context) => {},
      ),
      SettingsTile.switchTile(
        title: const TitleDesc(
            title: 'Dock to Side',
            description:
                'Align application to the left side of the main display'),
        leading: const Icon(Icons.dock),
        initialValue: null,
        trailing: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              saveDockToSide();
            }),
        onToggle: (value) {
         
        },
        onPressed: (context) => {},
      )
    ]);
  }

  savePinWindow(bool value) async {
    settingProvider.pinWindow();
    settingProvider.appSettings.alwaysOnTop = value;
    await settingProvider.saveSettings();
  }

  saveDockToSide() async {
    settingProvider.dockToSide();
    settingProvider.appSettings.dockToSide = true;
    await settingProvider.saveSettings();
  }

  enableWindowMode(bool value) async {
    settingProvider.enableWindowMode(value);
    settingProvider.appSettings.windowMode = value;
    await settingProvider.saveSettings();
  }
}
