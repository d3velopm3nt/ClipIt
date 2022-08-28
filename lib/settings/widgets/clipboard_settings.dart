import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../services/clip_manager_service.dart';
import '../../ui/widgets/shared/confirm_dialog.dart';
import '../../ui/widgets/shared/title_desc_widget.dart';

class ClipboardClearSetting extends SettingsSection {
 late ClipManager manager;
  ClipboardClearSetting({Key? key}) : super(key: key, tiles: []);

  @override
  Widget build(BuildContext context) {
    manager = Provider.of<ClipManager>(context);
    return SettingsSection(title: const Text('Clipboard Settings'), tiles: [
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
}
