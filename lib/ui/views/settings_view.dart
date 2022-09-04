import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/settings/widgets/application_settings.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../settings/widgets/clipboard_settings.dart';
import '../../settings/widgets/theme_settings.dart';

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
            ApplicationSettings(),
            ThemeSettings(),
            ClipboardClearSetting()
        ],
      ),
    );
  }
}
