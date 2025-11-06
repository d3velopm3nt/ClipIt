import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../app/app.notification.dart';
import '../../services/clip_manager_service.dart';
import '../../ui/widgets/shared/confirm_dialog.dart';
import '../../ui/widgets/shared/title_desc_widget.dart';
import '../services/settings_service.dart';

class ClipboardClearSetting extends SettingsSection {
  late ClipManager manager;
  bool isLoading = false;
  SettingsService settingProvider = SettingsService();
  ClipboardClearSetting({Key? key}) : super(key: key, tiles: []);

  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of<SettingsService>(context);
    manager = Provider.of<ClipManager>(context);
    return SettingsSection(title: const Text('Clipboard Settings'), tiles: [
      SettingsTile(
        title: const TitleDesc(
            title: 'Active Clip Limit',
            description: 'Maximum number of clips to keep active (older clips are archived)'),
        leading: const Icon(Icons.archive),
        trailing: SizedBox(
          width: 100,
          child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: TextEditingController(
                text: settingProvider.appSettings.maxActiveClips.toString()),
            onChanged: (value) {
              final newValue = int.tryParse(value);
              if (newValue != null && newValue > 0) {
                setMaxActiveClips(newValue);
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            ),
          ),
        ),
      ),
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
          leading: const Icon(Icons.archive),
          initialValue: null,
          trailing: IconButton(
              tooltip: 'Archive Excess Clips',
              icon: const Icon(Icons.archive_outlined, color: Colors.blue),
              onPressed: () => {_archiveExcessClips(context)},
            ),
          onToggle: (value) {},
          title: const TitleDesc(
              title: 'Archive Excess Clips',
              description: 'Move clips over the active limit to archive')),
      SettingsTile.switchTile(
          leading: const Icon(Icons.delete),
          initialValue: null,
          trailing: isLoading
              ? const CircularProgressIndicator()
              : IconButton(
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
                    isLoading = true,
                    if (confirm)
                      {isLoading = await manager.deleteClips() ? false : false}
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

  void setMaxActiveClips(int value) async {
    settingProvider.appSettings.maxActiveClips = value;
    await settingProvider.saveSettings();
    AppNotification.saveNotification(
      "Active Clip Limit Updated",
      "Set to $value clips (older clips will be archived)"
    );
  }

  void _archiveExcessClips(BuildContext context) async {
    final activeClips = manager.clips.length;
    final limit = settingProvider.appSettings.maxActiveClips;

    if (activeClips <= limit) {
      AppNotification.infoNotification(
        "No Clips to Archive",
        "You have $activeClips clips (limit: $limit)"
      );
      return;
    }

    final clipsToArchive = activeClips - limit;
    await manager.archiveOldClips(settingProvider);
  }
}
