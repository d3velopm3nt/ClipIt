import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import '../services/setting_changer.dart';
import '../../ui/widgets/title_desc_widget.dart';


class PinWindowSetting extends SettingsTile {
  PinWindowSetting({Key? key}) : super(key: key,title: const Text(''));


  @override
  SettingsTile build(BuildContext context) {
    var settingProvider = Provider.of<SettingChanger>(context);
    return SettingsTile.switchTile(
      title: const TitleDesc(title:'Pin Clipboard',description:'Keep the application always on top'),
      leading: const Icon(Icons.push_pin),
      initialValue: settingProvider.windowPinned.state,
      onToggle: (value) {
        settingProvider.pinWindow();
      },
      onPressed: (context) => {},
    );
  }
}