import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import '../services/setting_changer.dart';
import '../../ui/widgets/shared/title_desc_widget.dart';

class ApplicationSettings extends SettingsSection {
  ApplicationSettings({Key? key}) : super(key: key, tiles: []);

  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<SettingChanger>(context);

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
          settingProvider.pinWindow();
        },
        onPressed: (context) => {},
      ),
      SettingsTile.switchTile(
        title: const TitleDesc(
            title: 'Window Mode',
            description: 'This will add the titlebar to the application'),
        leading: const Icon(Icons.window),
        initialValue: settingProvider.windowMode,
        onToggle: (value) {
          settingProvider.enableWindowMode(value);
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
              settingProvider.dockToSide();
            }),
        onToggle: (value) {
          settingProvider.enableWindowMode(value);
        },
        onPressed: (context) => {},
      )
    ]);
  }
}
