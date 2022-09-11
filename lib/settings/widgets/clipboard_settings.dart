import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../services/clip_manager_service.dart';
import '../../ui/widgets/shared/confirm_dialog.dart';
import '../../ui/widgets/shared/title_desc_widget.dart';
import '../services/settings_service.dart';

class ClipboardClearSetting extends SettingsSection {
  late ClipManager manager;
  SettingsService settingProvider = SettingsService();
  ClipboardClearSetting({Key? key}) : super(key: key, tiles: []);

  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of<SettingsService>(context);
    manager = Provider.of<ClipManager>(context);
    return SettingsSection(title: const Text('Clipboard Settings'), tiles: [
      SettingsTile.switchTile(
        enabled: !settingProvider.appSettings.showQuickSelect,
        title: const TitleDesc(
            title: 'Hide after copy',
            description:
                'Hide the clipboard after you have copied something from it'),
        leading: const Icon(Icons.hide_source),
        initialValue: settingProvider.appSettings.hideClipboardAfterCopy,
        onToggle: (value) {
          enableHideClipboard(value);
        },
        onPressed: (context) => {},
      ),
      SettingsTile.switchTile(
        title: const TitleDesc(
            title: 'Show Quick Select',
            description: 'Easy assign tags and groups to the text'),
        leading: const Icon(Icons.quickreply),
        initialValue: settingProvider.appSettings.showQuickSelect,
        onToggle: (value) {
          showQuickSelect(value);
        },
        onPressed: (context) => {},
      ),
      SettingsTile.switchTile(
          leading: const Icon(Icons.delete),
          initialValue: null,
          trailing: IconButton(
            tooltip: 'Delete Clips',
            icon: const Icon(Icons.delete_forever, color: Colors.red),
            onPressed: () => {_delete(context)},
          ),
          onToggle: (value) {},
          title: const TitleDesc(
              title: 'Delete All Clips',
              description: 'This will remove all clips from the disk'))
      //onPressed: (context) => {manager.deleteClips()})
    ]);
  }

  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return ConfirmDailog(
              onConfirm: (confirm) async => {
                    if (confirm) {manager.deleteClips()}
                  });
        });
  }

  void enableHideClipboard(bool value) async {
    settingProvider.enableHideClipboard(value);
    await settingProvider.saveSettings();
  }

  void showQuickSelect(bool value) async {
     settingProvider.showQuickSelect(value);
    await settingProvider.saveSettings();
  }
}
