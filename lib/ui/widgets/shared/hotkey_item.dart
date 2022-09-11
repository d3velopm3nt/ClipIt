import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:preference_list/preference_list.dart';
import 'package:provider/provider.dart';

import '../../../models/hotkey.model.dart';
import '../../../services/hotkey_service.dart';
import '../clip/clip_item_widget.dart';
import 'title_desc_widget.dart';

class HotKeyItem extends StatefulWidget {
  final HotKeyModel model;
  HotKeyItem({Key? key, required this.model}) : super(key: key);

  @override
  State<HotKeyItem> createState() => _HotKeyItemState();
}

class _HotKeyItemState extends State<HotKeyItem> {
  @override
  Widget build(BuildContext context) {
    final hotkeyService = Provider.of<HotKeyService>(context);
    return PreferenceListItem(
      padding: const EdgeInsets.all(12),
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TitleDesc(title: widget.model.title),
          ),
          HotKeyVirtualView(hotKey: hotkeyService.buildHotKey(widget.model))
        ],
      ),
      bottomView: Visibility(
        visible: true,
        child: ClipItemWidget(
            clip: hotkeyService.getHotkeyClip(widget.model.clipId)),
      ),
    );
  }
}
