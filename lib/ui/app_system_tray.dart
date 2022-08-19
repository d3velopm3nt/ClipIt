import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:system_tray/system_tray.dart';

String getTrayImagePath(String imageName) {
  return Platform.isWindows ? 'assets/$imageName.ico' : 'assets/$imageName.png';
}

String getImagePath(String imageName) {
  return Platform.isWindows ? 'assets/$imageName.bmp' : 'assets/$imageName.png';
}

class AppSystemTray {
   final AppWindow _appWindow = AppWindow();
  final SystemTray _systemTray = SystemTray();
  final Menu _menuMain = Menu();
  final Menu _menuSimple = Menu();
   bool _toogleTrayIcon = true;
Timer? _timer;
  bool _toogleMenu = true;


    Future<void> initSystemTray() async {
    // We first init the systray menu and then add the menu entries
    await _systemTray.initSystemTray(iconPath: getTrayImagePath('app_icon'));
    _systemTray.setTitle("system tray");
    _systemTray.setToolTip("Clip It Desktop");

    // handle system tray event
    _systemTray.registerSystemTrayEventHandler((eventName) {
      debugPrint("eventName: $eventName");
      if (eventName == kSystemTrayEventClick) {
        Platform.isWindows ? _appWindow.show() : _systemTray.popUpContextMenu();
      } else if (eventName == kSystemTrayEventRightClick) {
        Platform.isWindows ? _systemTray.popUpContextMenu() : _appWindow.show();
      }
    });

    await _menuMain.buildFrom(
      [
        MenuSeparator(),
        MenuItemLable(
            label: 'Show',
            onClicked: (menuItem) => _appWindow.show()),
        MenuItemLable(
            label: 'Hide',
            onClicked: (menuItem) => _appWindow.hide()),
        MenuSeparator(),
        MenuItemLable(
            label: 'Exit', onClicked: (menuItem) => _appWindow.close()),
      ],
    );

    await _menuSimple.buildFrom([
      MenuSeparator(),
      MenuItemLable(
          label: 'Show',
          onClicked: (menuItem) => _appWindow.show()),
      MenuItemLable(
          label: 'Hide',
          onClicked: (menuItem) => _appWindow.hide()),
      MenuItemLable(
        label: 'Exit',
        onClicked: (menuItem) => _appWindow.close(),
      ),
    ]);

    _systemTray.setContextMenu(_menuMain);
  }
}