import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_my_clipboard/models/hotkey.model.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import '../app/app.notification.dart';
import '../hotkey/keyboard_simulator.dart';
import '../navigation/app.navigation.dart';
import '../ui/display_manager.dart';
import 'box/box_serice_base.dart';
import 'clip_manager_service.dart';

class HotKeyService extends BoxServiceBase<HotKeyModel> {
  ClipManager clipManager = ClipManager();
  late List<HotKey> _registeredHotKeyList;
  List<HotKey> get registeredHotKeyList => _registeredHotKeyList;

  @override
  late String boxName = "hotkeys";

  Future<bool> saveHotKey(HotKey key, String clipId, String title) async {
    if (await _registerHotKey(key)) {
      HotKeyModel model = HotKeyModel(key.identifier, key.keyCode.name,
          _mapModifiersToModel(key.modifiers), clipId, title);
      await save(model);
      return true;
    } else {
      return false;
    }
  }

  HotKey buildHotKey(HotKeyModel key) {
    return HotKey(
      _getKeyCodeEnum(key.keyCode),
      modifiers: _mapModifiersFromModel(key.modifiers),
      identifier: key.id,
    );
  }

  @override
  Future<void> delete(key) async {
    var hkey = buildHotKey(key);
    unRegisterHotKey(hkey);
    //_registeredHotKeyList.removeWhere((x)=>x.identifier == hkey.identifier);
    await super.delete(key);
  }

  Future<bool> _registerHotKey(HotKey key) async {
    if (!hotKeyManager.registeredHotKeyList
        .any((element) => element.keyCode == key.keyCode)) {
      await hotKeyManager.register(
        key,
        keyDownHandler: _keyDownHandler,
      );
      _registeredHotKeyList = hotKeyManager.registeredHotKeyList;
      return true;
    } else {
      AppNotification.warningNotification(
          "Key already assign to another action",
          "No hot key was created, please try another combination");
      return false;
    }
  }

  HotKeyModel? getHotKeyByClipId(String id) {
    var key = list.where((element) => element.clipId == id).toList();
    return key.isNotEmpty ? key.first : null;
  }

  unRegisterHotKey(HotKey key) async {
    await hotKeyManager.unregister(key);
    _registeredHotKeyList = hotKeyManager.registeredHotKeyList;
  }

  _keyDownHandler(HotKey key) async {
    //Check if key is registred again clip then copy and past textbuildHotKey(key)
    var model = list.where((k) => k.id == key.identifier).first;
    var clip = clipManager.getClipById(model.clipId);
    ClipboardData data = ClipboardData(text: clip.copiedText);
    await Clipboard.setData(data);
    await Future.delayed(const Duration(milliseconds: 500));
    KeyboardSimulator.paste();
  }

  getHotkeyClip(String id) {
    return clipManager.getClipById(id);
  }

  Future<void> load(ClipManager clipManager) async {
    this.clipManager = clipManager;
    _registeredHotKeyList = [];
    await hotKeyManager.unregisterAll();
    await loadBox();
    await _loadPopupKey();
    await _loadSavedKeys();
    // refresh();
    _registeredHotKeyList = hotKeyManager.registeredHotKeyList;
  }

  _loadPopupKey() async {
    HotKey hotKey = HotKey(
      KeyCode.keyC,
      modifiers: [KeyModifier.alt],
      // Set hotkey scope (default is HotKeyScope.system)
      scope: HotKeyScope.system, // Set as inapp-wide hotkey.
    );
    if (!hotKeyManager.registeredHotKeyList
        .any((element) => element == hotKey)) {
      await hotKeyManager.register(
        hotKey,
        keyDownHandler: (hotKey) {
          if (AppRoutes.quickSelect == AppNavigation.currentRoute) {
            AppNavigation.navigateToRoute(AppRoutes.home);
          }
          DisplayManager.clipboardView();
        },
      );
    }
  }

  _loadSavedKeys() async {
    var keys = list.map((key) => buildHotKey(key)).toList();

    for (var i = 0; i < keys.length; i++) {
      await _registerHotKey(keys[i]);
    }
  }

  List<KeyModifier> _mapModifiersFromModel(List<String> modifiers) {
    return modifiers.map((modifier) => _getKeyModifierEnum(modifier)).toList();
  }

  List<String> _mapModifiersToModel(List<KeyModifier>? modifiers) {
    return modifiers!.map((modifier) => modifier.name).toList();
  }

  KeyCode _getKeyCodeEnum(String code) {
    return KeyCode.values
        .firstWhere((element) => describeEnum(element) == code);
  }

  KeyModifier _getKeyModifierEnum(String code) {
    return KeyModifier.values
        .firstWhere((element) => describeEnum(element) == code);
  }

  unregisterAll() async {
    await hotKeyManager.unregisterAll();
    _registeredHotKeyList = hotKeyManager.registeredHotKeyList;
    await deleteAll();
  }
}
