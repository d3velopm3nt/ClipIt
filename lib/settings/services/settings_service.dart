import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/services/box/box_serice_base.dart';
import 'package:flutter_my_clipboard/services/box/boxes.dart';
import 'package:flutter_my_clipboard/settings/contracts/settings_service.interface.dart';
import 'package:flutter_my_clipboard/settings/models/settings.model.dart';
import 'package:flutter_my_clipboard/theme/theme_changer.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

import '../../models/pinned.model.dart';

class SettingsService extends BoxServiceBase<SettingsModel>
    implements SettingsServiceInterface {
  final Map<String, dynamic> _settings = {};
  bool loaded = false;
  final Pinned _windowPinned = Pinned();
  Pinned get windowPinned => _windowPinned;
  @override
  String get boxName => "settingsBox";

  // Create a computed SettingsModel for backward compatibility
  SettingsModel get appSettings => SettingsModel('settings', _settings);

  T _getSetting<T>(String name, T defaultValue) {
    return _settings[name] ?? defaultValue;
  }

  void _setSetting(String name, dynamic value) {
    _settings[name] = value;
  }

  //SettingChanger settingChanger = SettingChanger();
  //ThemeChanger themeChanger = ThemeChanger();

  @override
  Future<void> loadSettings(ThemeChanger themeChanger) async {
    if (loaded) return;
    // await loadBox();
    box = Boxes.settingsBox;
    loadList();

    // Load all settings from the box into the map
    for (var setting in list) {
      _settings[setting.name] = setting.value;
    }

    // Apply default values for missing settings
    _ensureDefaultSettings();

    //dock to side
    if (_getSetting('dockToSide', true)) _dockToSide();
    // windows mode
    if (_getSetting('alwaysOnTop', false)) pinWindow();
    // Launch At Startup
    _launchAtStartup(_getSetting('launchAtStartup', false));
    //Enable Window Mode
    enableWindowMode(_getSetting('windowMode', false));

    // dark mode
    themeChanger.setDarkMode(_getSetting('darkMode', false));
    // primary color
    if (_getSetting('primaryColor', 0) != 0) {
      themeChanger.setPrimaryColor(Color(_getSetting('primaryColor', 0)));
    }
    // second color
    if (_getSetting('secondaryColor', 0) != 0) {
      themeChanger.setSecondColor(Color(_getSetting('secondaryColor', 0)));
    }

    loaded = true;
  }

  void _ensureDefaultSettings() {
    final defaults = {
      'darkMode': false,
      'windowMode': false,
      'primaryColor': 0,
      'secondaryColor': 0,
      'alwaysOnTop': false,
      'dockToSide': true,
      'launchAtStartup': false,
      'hideClipboardAfterCopy': false,
      'showQuickSelect': false,
      'setupDone': false,
      'maxActiveClips': 100,
    };

    defaults.forEach((key, value) {
      if (!_settings.containsKey(key)) {
        _settings[key] = value;
      }
    });
  }

  @override
  Future<void> saveSettings() async {
    // Save all current settings to the box
    for (var entry in _settings.entries) {
      var existingSetting = list.where((s) => s.name == entry.key).toList();
      if (existingSetting.isNotEmpty) {
        existingSetting.first.value = entry.value;
        await existingSetting.first.save();
      } else {
        var newSetting = SettingsModel(entry.key, entry.value);
        await save(newSetting);
      }
    }
  }

  Future<void> saveSetting(String name, dynamic value) async {
    _settings[name] = value;

    var existingSetting = list.where((s) => s.name == name).toList();
    if (existingSetting.isNotEmpty) {
      existingSetting.first.value = value;
      await existingSetting.first.save();
    } else {
      var newSetting = SettingsModel(name, value);
      await save(newSetting);
    }
  }

  pinWindow() {
    _setPinnedWindow();
    notifyListeners();
  }

  _setPinnedWindow() async {
    if (!_windowPinned.state) {
      _windowPinned.icon = Icons.adjust;
      _windowPinned.state = true;
      _windowPinned.tooltip = "Unpin Clipboard";
      WindowManager.instance.setAlwaysOnTop(true);
    } else {
      WindowManager.instance.setAlwaysOnTop(false);
      _windowPinned.icon = Icons.push_pin;
      _windowPinned.state = false;
      _windowPinned.tooltip = "Pin to Top";
    }
    await saveSetting('alwaysOnTop', _windowPinned.state);
  }

  enableWindowMode(bool enabled) async {
    await saveSetting('windowMode', enabled);
    enabled
        ? WindowManager.instance.setTitleBarStyle(TitleBarStyle.normal)
        : await WindowManager.instance.setAsFrameless();
    notifyListeners();
  }

  dockToSide() async {
    await _dockToSide();
  }

  _dockToSide() async {
    var display = await screenRetriever.getPrimaryDisplay();
    //await WindowManager.instance.setAsFrameless();
    await WindowManager.instance.setSize(Size(350, display.size.height - 40));
    await WindowManager.instance
        .setAlignment(Alignment.topRight, animate: true);
    notifyListeners();
  }

  launchAtStartup(bool value) async {
    await _launchAtStartup(value);
  }

  _launchAtStartup(bool value) async {
    await saveSetting('launchAtStartup', value);
    value
        ? LaunchAtStartup.instance.enable()
        : LaunchAtStartup.instance.disable();
    notifyListeners();
  }

  enableHideClipboard(bool value) async {
    await saveSetting('hideClipboardAfterCopy', value);
    notifyListeners();
  }

  showQuickSelect(bool value) async {
    await _showQuickSelect(value);
  }

  _showQuickSelect(bool value) async {
    await saveSetting('showQuickSelect', value);
    notifyListeners();
  }
}
