import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:flutter_my_clipboard/services/hotkey_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_my_clipboard/navigation/app.navigation.dart';
import 'package:flutter_my_clipboard/services/clip_manager_service.dart';
import '../../../navigation/clip.navigation.dart';
import '../../../navigation/navigation_manager.dart';
import '../../../services/clip_tag_service.dart';
import '../../../settings/services/setting_changer.dart';
import '../saved/saved_menu.dart';
import 'clip_menu.dart';

class ClipManagerPage extends StatefulWidget {
  const ClipManagerPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<ClipManagerPage> createState() => _ClipManagerPageState();
}

class _ClipManagerPageState extends State<ClipManagerPage>
    with ClipboardListener {
  IconData pinnedIcon = Icons.push_pin;
  String pinnedIconTooltip = "Pin To Top";
  List<LogicalKeyboardKey> keys = [];
  ClipManager _manager = ClipManager();
  ClipTagService tagManager = ClipTagService();
  HotKeyService hotKeyService = HotKeyService();
  @override
  void initState() {
    clipboardWatcher.addListener(this);
    clipboardWatcher.start();
    Future.delayed(Duration.zero, () async {
      await hotKeyService.load();
      await _manager.loadClips();
      //Load Test
     // await AppLoadTest.copyToClipboard('TEST', 50);
      
    });
    super.initState();
  }

  @override
  void onClipboardChanged() async {
    ClipboardData? newClipboardData =
        await Clipboard.getData(Clipboard.kTextPlain);
    var newText = newClipboardData?.text ?? "";
    if (newText != "" && !_manager.clips.any((x) => x.copiedText == newText)) {
      _manager.saveClip(newText);
    } else if (newText != "") {
      await _manager.updateClipDate(newText);
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
    var settingsProvider = Provider.of<SettingChanger>(context);
    final navigation = Provider.of<NavigationManager>(context);
    _manager = Provider.of<ClipManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: navigation.isNavMain
            ? const Text('Clip It')
            : Row(children: [
                IconButton(
                    onPressed: () {
                      navigation.changeNav(NavRoutes.main);
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Text("Saved")
              ]),
        toolbarHeight: 50.0, // add this line
        actions: <Widget>[
          IconButton(
              tooltip: settingsProvider.windowPinned.tooltip,
              icon: Icon(
                settingsProvider.windowPinned.icon,
                color: Colors.white,
              ),
              onPressed: () {
                settingsProvider.pinWindow();
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
