import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/services/box/box_serice_base.dart';
import 'package:flutter_my_clipboard/settings/contracts/settings_service.interface.dart';
import 'package:flutter_my_clipboard/settings/models/settings.model.dart';
import 'package:flutter_my_clipboard/theme/theme_changer.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

import '../../models/pinned.model.dart';

class SettingsService extends BoxServiceBase<SettingsModel>
    implements SettingsServiceInterface {
  late SettingsModel _settings;
  final Pinned _windowPinned = Pinned();
  Pinned get windowPinned => _windowPinned;
  @override
  String get boxName => "settings";
  @override
  SettingsModel get appSettings => _settings;

  //SettingChanger settingChanger = SettingChanger();
  //ThemeChanger themeChanger = ThemeChanger();

  @override
  Future<void> loadSettings(ThemeChanger themeChanger) async {
    await loadBox();
    if (list.isNotEmpty) {
      _settings = list.first;
      //dock to side
      _settings.dockToSide ? dockToSide() : null;
      // // windows mode
      _settings.alwaysOnTop ? pinWindow() : null;
      // Launch At Startup
      launchAtStartup(_settings.launchAtStartup);
      // dark mode
      themeChanger.setDarkMode(_settings.darkMode);
      // primary color
      if (_settings.primaryColor != 0) {
        themeChanger.setPrimaryColor(Color(_settings.primaryColor));
      }
      // second color
      if (_settings.secondaryColor != 0) {
        themeChanger.setSecondColor(Color(_settings.secondaryColor));
      }
    } else {
      _settings = SettingsModel(false, true, false, false, 0, 0, false, false,false);
      await save(_settings);
    }
  }

  @override
  Future<void> saveSettings() async {
    await save(appSettings);
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
    appSettings.alwaysOnTop = _windowPinned.state;
    await saveSettings();
  }

  enableWindowMode(bool enabled) async {
    appSettings.windowMode = enabled;
    enabled
        ? WindowManager.instance.setTitleBarStyle(TitleBarStyle.normal)
        : await WindowManager.instance.setAsFrameless();
    notifyListeners();
  }

  dockToSide() async {
    var display = await screenRetriever.getPrimaryDisplay();
    await WindowManager.instance.setAsFrameless();
    await WindowManager.instance.setSize(Size(300, display.size.height - 40));
    await WindowManager.instance
        .setAlignment(Alignment.topRight, animate: true);
    notifyListeners();
  }

  launchAtStartup(bool value) async {
    appSettings.launchAtStartup = value;
    value
        ? LaunchAtStartup.instance.enable()
        : LaunchAtStartup.instance.disable();
    notifyListeners();
  }

  enableHideClipboard(bool value) async {
    appSettings.hideClipboardAfterCopy = value;
    notifyListeners();
  }

  showQuickSelect(bool value) async {
    appSettings.showQuickSelect = value;
    notifyListeners();
  }
}
