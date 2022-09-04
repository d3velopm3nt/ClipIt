import 'package:flutter/material.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

import '../navigation/app.navigation.dart';

class DisplayManager {
  static clipboardView() async {
     await WindowManager.instance.setAsFrameless();
    var display = await screenRetriever.getPrimaryDisplay();
    await WindowManager.instance.setSize(Size(300, display.size.height - 40));
    await WindowManager.instance
        .setAlignment(Alignment.topRight, animate: true);
    WindowManager.instance.setSkipTaskbar(true);
    WindowManager.instance.show();
  }

  static quickView() async {
    AppNavigation.navigateToRoute(AppRoutes.quickSelect);
    var display = await screenRetriever.getPrimaryDisplay();
    await WindowManager.instance.setSize(Size(300, 200));
    WindowManager.instance.setPosition(Offset(display.size.width - 300, 10));
    WindowManager.instance.setTitleBarStyle(TitleBarStyle.hidden);
    WindowManager.instance.setAlwaysOnTop(true);
    WindowManager.instance.setAlwaysOnTop(false);
    WindowManager.instance.show();
  }
}
