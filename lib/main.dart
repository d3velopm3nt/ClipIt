import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/clip-viewer.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';
import 'ui/app_system_tray.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await WindowManager.instance.ensureInitialized();
  runApp(const MyApp());
   AppSystemTray tray = AppSystemTray();
    await tray.initSystemTray();
  // Use it only after calling `hiddenWindowAtLaunch`
  WindowManager.instance.waitUntilReadyToShow().then((_) async {
    WindowManager.instance.hide();
    //Set to frameless window
    await WindowManager.instance.setAsFrameless();
    var display = await screenRetriever.getPrimaryDisplay();
    await WindowManager.instance.setSize(Size(300, display.size.height - 40));
    // await WindowManager.instance.setPosition(Offset(500, 300));
     await WindowManager.instance
         .setAlignment(Alignment.topRight, animate: true);
    // WindowManager.instance.setAlwaysOnTop(true);
    WindowManager.instance.setSkipTaskbar(true);
    WindowManager.instance.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clip It Desktop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Clip It - v.0.0.0'),
    );
  }
}
