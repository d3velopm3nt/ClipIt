import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/models/pinned.model.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

class SettingChanger extends ChangeNotifier {
  final Pinned _windowPinned = Pinned();
  bool _windowMode = false;

  final bool _dockApp = true;

  Pinned get windowPinned => _windowPinned;

  bool get windowMode => _windowMode;

  bool get dockApp => _dockApp;

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

  enableWindowMode(bool enabled) async {
    _windowMode = enabled;
    _windowMode ? 
    WindowManager.instance.setTitleBarStyle( TitleBarStyle.normal ) :
     await WindowManager.instance.setAsFrameless();
    notifyListeners();
  }

  dockToSide() async{

        var display = await screenRetriever.getPrimaryDisplay();
    await WindowManager.instance.setSize(Size(300, display.size.height - 40));
    await WindowManager.instance.setAlignment(Alignment.topRight, animate: true);
    notifyListeners();
  }
  
}
