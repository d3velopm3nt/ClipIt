import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/models/pinned.model.dart';
import 'package:window_manager/window_manager.dart';

class SettingChanger extends ChangeNotifier {
  final Pinned _windowPinned = Pinned();

  Pinned get windowPinned => _windowPinned;

  pinWindow() {
    _setPinnedWindow();
    notifyListeners();
  }

  _setPinnedWindow() {
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
  }
}
