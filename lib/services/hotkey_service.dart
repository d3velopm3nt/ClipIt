import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';

class HotKeyService extends ChangeNotifier {
  late List<HotKey> _registeredHotKeyList = [];

  List<HotKey> get registeredHotKeyList => _registeredHotKeyList;

  registerHotKey(HotKey key) async {
    
        await hotKeyManager.register(
      key,
      keyDownHandler: _keyDownHandler,
    );
    _registeredHotKeyList = hotKeyManager.registeredHotKeyList;
    notifyListeners();
  }

  unRegisterHotKey(HotKey key) async {
    await hotKeyManager.unregister(key);
     _registeredHotKeyList = hotKeyManager.registeredHotKeyList;
  }

  _keyDownHandler(HotKey key) async {
    //Check if key is registred again clip then copy and past text
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
