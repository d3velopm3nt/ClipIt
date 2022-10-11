import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:flutter_my_clipboard/app/app.config.dart';
import 'package:flutter_my_clipboard/services/hotkey_service.dart';
import 'package:flutter_my_clipboard/settings/services/settings_service.dart';
import 'package:flutter_my_clipboard/ui/display_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter_my_clipboard/navigation/app.navigation.dart';
import 'package:flutter_my_clipboard/services/clip_manager_service.dart';
import '../../../navigation/clip.navigation.dart';
import '../../../navigation/navigation_manager.dart';
import '../../../services/clip_tag_service.dart';
import '../../../theme/theme_changer.dart';
import '../saved/saved_menu.dart';
import 'clip_menu.dart';

class ClipManagerPage extends StatefulWidget {
  const ClipManagerPage({Key? key}) : super(key: key);

  @override
  State<ClipManagerPage> createState() => _ClipManagerPageState();
}

class _ClipManagerPageState extends State<ClipManagerPage>
    with ClipboardListener {
  IconData pinnedIcon = Icons.push_pin;
  String pinnedIconTooltip = "Pin To Top";
  List<LogicalKeyboardKey> keys = [];
  ThemeChanger theme = ThemeChanger();
  ClipManager _manager = ClipManager();
  ClipTagService tagManager = ClipTagService();
  HotKeyService hotKeyService = HotKeyService();
  SettingsService settingService = SettingsService();
  @override
  void initState() {
    clipboardWatcher.addListener(this);
    clipboardWatcher.start();
    Future.delayed(Duration.zero, () async {
      await settingService.loadSettings(theme);
      await tagManager.loadTags();
      await _manager.loadClips();
      await hotKeyService.load(_manager);

       if (!settingService.appSettings.setupDone && !AppConfig.introSkipped) {
      DisplayManager.introView();
    }
    else
    {
      DisplayManager.clipboardView();
    }
    });
    
    super.initState();
  }

  static String lastclip = "";
  @override
  void onClipboardChanged() async {
    ClipboardData? newClipboardData =
        await Clipboard.getData(Clipboard.kTextPlain);
    var newText = newClipboardData?.text ?? "";
    if (newText != "" && newText != lastclip) {
      lastclip = newText;
      if (!_manager.clips.any((x) => x.copiedText == newText)) {
        _manager.saveClip(newText);
      //Show if enabled in settings and not copied from clipboard
      if (settingService.appSettings.showQuickSelect &&
          !AppConfig.copiedFromClipboard) {
        await DisplayManager.quickView();
      }
      AppConfig.copiedFromClipboard = false;
      } else if (newText != "") {
        await _manager.updateClipDate(newText);
      }
    }
  }

  openSettings() async {
    // await WindowManager.instance.setSize(const Size(500, 500));
    // WindowManager.instance.setTitleBarStyle(TitleBarStyle.normal);
    // await WindowManager.instance.setAlignment(Alignment.center);
    AppNavigation.navigateToRoute(AppRoutes.settings);
  }

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeChanger>(context);
    settingService = Provider.of<SettingsService>(context);

    final navigation = Provider.of<NavigationManager>(context);
    _manager = Provider.of<ClipManager>(context);
    tagManager = Provider.of<ClipTagService>(context);
    hotKeyService = Provider.of<HotKeyService>(context);

   

    return Scaffold(
      appBar: AppBar(
        title: navigation.isNavMain
            ? const Text('Clip It')
            : Row(children: [
                IconButton(
                    onPressed: () {
                      navigation.changeNav(NavRoutes.main);
                      ClipNavigation.previousPage();
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Text("Saved")
              ]),
        toolbarHeight: 50.0, // add this line
        actions: <Widget>[
          IconButton(
              tooltip: settingService.windowPinned.tooltip,
              icon: Icon(
                settingService.windowPinned.icon,
                color: Colors.white,
              ),
              onPressed: () {
                settingService.pinWindow();
              }),
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              openSettings();
            },
          )
        ],
      ),
      body: Column(
        children: [
          navigation.isNavMain ? const ClipMenu() : const SavedMenu(),
          SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width,
            child: Navigator(
              key: ClipNavigation.nav,
              initialRoute: '/clipboard',
              onGenerateRoute: (RouteSettings route) =>
                  ClipNavigation.navigationRoutes(route.name, route.arguments),
            ),
          ),
        ],
      ),
    );
  }
}
