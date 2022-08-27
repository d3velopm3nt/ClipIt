import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../services/clip_manager_service.dart';
import '../../ui/widgets/title_desc_widget.dart';

class ClipboardClearSetting extends SettingsTile {
  ClipboardClearSetting({Key? key}) : super(key: key, title: const Text(''));

  @override
  Widget build(BuildContext context) {
    final manager =Provider.of<ClipManager>(context);
    return SettingsTile.navigation(
        leading: const Icon(Icons.language),
        title: const TitleDesc(title:'Delete All Clips',description:'This will remove all clips from the disk'),
        
        // value: ElevatedButton(
        //   onPressed: () {},
        //   child: const Text("Delete"),
        // ),
        onPressed: (context) => { manager.deleteClips()});
  }
}
