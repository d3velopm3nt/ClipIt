import 'package:flutter/services.dart';
import 'package:flutter_my_clipboard/models/hotkey.model.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';

import '../hotkey/keyboard_simulator.dart';
import '../models/clipitem.model.dart';
import 'box/box_serice_base.dart';
import 'clip_manager_service.dart';

class HotKeyService extends BoxServiceBase<HotKeyModel> {
  ClipManager clipManager = ClipManager();
  late List<HotKey> _registeredHotKeyList;
  List<HotKey> get registeredHotKeyList => _registeredHotKeyList;

  @override
  late String boxName = "hotkeys";

  registerHotKey(HotKey key, String clipId) async {
    await loadBox();
    await hotKeyManager.register(
      key,
      keyDownHandler: _keyDownHandler,
    );
    _registeredHotKeyList = hotKeyManager.registeredHotKeyList;
    HotKeyModel model = HotKeyModel(
        key.identifier, key.keyCode, key.modifiers, key.scope, clipId);
    await save(model);
  }

  unRegisterHotKey(HotKey key) async {
    await hotKeyManager.unregister(key);
    _registeredHotKeyList = hotKeyManager.registeredHotKeyList;
  }

  _keyDownHandler(HotKey key) async {
    //Check if key is registred again clip then copy and past text
    // var model = list.where((k) => k.id == key.identifier).first;
    // if (model != null) {
    //   var clip = await clipManager.getClipById(model.clipId);
      // ClipboardData data = ClipboardData(text: clip.copiedText);
      // await Clipboard.setData(data);
      KeyboardSimulator.simulate();
      // Clipboard.getData(Clipboard.kTextPlain);
    }

  Future<void> load() async {
    await hotKeyManager.unregisterAll();

    HotKey hotKey = HotKey(
      KeyCode.keyC,
      modifiers: [KeyModifier.alt],
      // Set hotkey scope (default is HotKeyScope.system)
      scope: HotKeyScope.system, // Set as inapp-wide hotkey.
    );
    await hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        WindowManager.instance.show();
      },
    );
  }

  unregisterAll() async {
    await hotKeyManager.unregisterAll();
    _registeredHotKeyList = hotKeyManager.registeredHotKeyList;
  }
}
