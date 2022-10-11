import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/services/clip_tag_service.dart';
import 'package:flutter_my_clipboard/settings/services/settings_service.dart';
import 'package:flutter_my_clipboard/theme/theme_changer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:window_manager/window_manager.dart';
import 'models/clipitem.model.dart';
import 'models/cliptag.model.dart';
import 'models/hotkey.model.dart';
import 'navigation/navigation_manager.dart';
import 'services/clip_manager_service.dart';
import 'services/hotkey_service.dart';
import 'settings/models/settings.model.dart';
import 'ui/views/main_view.dart';
import 'ui/widgets/shared/app_system_tray.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Start Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ClipItemAdapter());
  Hive.registerAdapter(ClipTagAdapter());
  Hive.registerAdapter(HotKeyAdapter());
  Hive.registerAdapter(SettingsAdapter());

  configScreenLoader(
    loader: const AlertDialog(
      title: Text('Gobal Loader..'),
    ),
    bgBlur: 20.0,
  );

  // Ensure Windows  Manager is initialized
  await WindowManager.instance.ensureInitialized();
  runApp(const App());
  AppSystemTray tray = AppSystemTray();
  //Sytem Tray initialized
  await tray.initSystemTray();
  //Setup Launch At Startup
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  LaunchAtStartup.instance.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );

  // Use it only after calling `hiddenWindowAtLaunch`
  WindowManager.instance.waitUntilReadyToShow().then((_) async {
    WindowManager.instance.hide();
    WindowManager.instance.setTitle("Clippet Desktop");
     WindowManager.instance.setIcon("assets/app_icon.ico");
    //Set to frameless window
    // DisplayManager.clipboardView();p
    WindowManager.instance.setSkipTaskbar(true);
  });
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => SettingsService()),
      ChangeNotifierProvider(create: (_) => ThemeChanger()),
      ChangeNotifierProvider(create: (_) => ClipManager()),
      ChangeNotifierProvider(create: (_) => ClipTagService()),
      ChangeNotifierProvider(create: (_) => NavigationManager()),
      ChangeNotifierProvider(create: (_) => HotKeyService()),
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
