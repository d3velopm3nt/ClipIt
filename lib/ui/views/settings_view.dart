import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/settings/widgets/pin_window_setting.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../settings/widgets/clipboard_clear_setting.dart';
import '../../settings/widgets/theme_setting.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
       // toolbarHeight: 50.0,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Application'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  value: const Text('English'),
                  onPressed: (context) => {}),
             ThemeSetting(),
             PinWindowSetting()
            ],
          ),
             SettingsSection(
               title: const Text('Clipboard'),
            tiles: <SettingsTile>[
                ClipboardClearSetting()
            ]
            )
        ],
      ),
    );
  }
}
