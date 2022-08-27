import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/services/clip_tag_service.dart';
import 'package:flutter_my_clipboard/theme/theme_changer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:window_manager/window_manager.dart';
import 'models/clipitem.model.dart';
import 'models/cliptag.model.dart';
import 'services/clip_manager_service.dart';
import 'theme/app.theme.dart';
import 'settings/services/setting_changer.dart';
import 'ui/views/main_view.dart';
import 'ui/widgets/app_system_tray.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Start Hive
  Hive.initFlutter();
  Hive.registerAdapter(ClipItemAdapter());
  Hive.registerAdapter(ClipTagAdapter());
  // Ensure Windows Manager is initialized
  await WindowManager.instance.ensureInitialized();
  runApp(const App());
  AppSystemTray tray = AppSystemTray();
  //Sytem Tray initialized
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

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ThemeChanger(lightTheme)),
      ChangeNotifierProvider(create: (_) => SettingChanger()),
      ChangeNotifierProvider(create: (_) => ClipManager()),
      ChangeNotifierProvider(create: (_) => ClipTagService())
    ], child: const AppTheme());
  }
}

class AppTheme extends StatelessWidget {
  const AppTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      builder: BotToastInit(), 
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      title: 'Clip It Desktop',
      theme: theme.getTheme,
      home: const MainWindow(),
    );
  }
}
