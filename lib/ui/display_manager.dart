import 'package:flutter/material.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';

import '../navigation/app.navigation.dart';

class DisplayManager {
  static clipboardView() async {
    await WindowManager.instance.setAsFrameless();
    var display = await screenRetriever.getPrimaryDisplay();
    await WindowManager.instance.setSize(Size(350, display.size.height - 40));
    await WindowManager.instance
        .setAlignment(Alignment.topRight, animate: true);
    WindowManager.instance.setSkipTaskbar(true);
    WindowManager.instance.show();
  }

  static quickView() async {
    AppNavigation.navigateToRoute(AppRoutes.quickSelect);
    var display = await screenRetriever.getPrimaryDisplay();
    var cursor = await screenRetriever.getCursorScreenPoint();
    await WindowManager.instance.setSize(const Size(300, 200));
    WindowManager.instance
        .setPosition(Offset(display.size.width - 300, 10));
    WindowManager.instance.setTitleBarStyle(TitleBarStyle.hidden);
    WindowManager.instance.show();
    WindowManager.instance.setAlwaysOnTop(true);
    WindowManager.instance.setAlwaysOnTop(false);
  }

  static introView() async {
    clipboardView();
    AppNavigation.navigateToRoute(AppRoutes.intro);
    //WindowManager.instance.setPosition(Offset(100));
    // WindowManager.instance.setFullScreen(true);
    // // await WindowManager.instance
    // //     .setAlignment(Alignment.bottomCenter, animate: true);
    // // await WindowManager.instance.setSize(const Size(500, 700));
    // await WindowManager.instance.setAlwaysOnTop(true);
    // WindowManager.instance.setTitleBarStyle(TitleBarStyle.normal);
    // await WindowManager.instance.show();
  }
}
