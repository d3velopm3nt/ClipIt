import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:provider/provider.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_my_clipboard/app/app.navigation.dart';
import 'package:flutter_my_clipboard/models/clipitem.model.dart';
import 'package:flutter_my_clipboard/services/clip_manager_service.dart';
import 'package:flutter_my_clipboard/ui/widgets/clip_item_widget.dart';
import '../settings/services/setting_changer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ClipboardListener {
  List<ClipItem> clips = [];
  IconData pinnedIcon = Icons.push_pin;
  String pinnedIconTooltip = "Pin To Top";
  List<LogicalKeyboardKey> keys = [];
  final ClipManager _manager = ClipManager();
  @override
  void initState() {
    clipboardWatcher.addListener(this);
    clipboardWatcher.start();
    Future.delayed(Duration.zero, () async {
      await loadHotKey();
      clips = await _manager.loadClips();
      setState(() {
        clips = clips;
      });
    });
    super.initState();
  }

  Future<void> loadHotKey() async {
    final AppWindow appWindow = AppWindow();
    await hotKeyManager.unregisterAll();
    // ⌥ + Q
    HotKey hotKey = HotKey(
      KeyCode.keyC,
      modifiers: [KeyModifier.alt],
      // Set hotkey scope (default is HotKeyScope.system)
      scope: HotKeyScope.system, // Set as inapp-wide hotkey.
    );
    await hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        appWindow.show();
      },
    );
  }

  @override
  void onClipboardChanged() async {
    ClipboardData? newClipboardData =
        await Clipboard.getData(Clipboard.kTextPlain);
    var newText = newClipboardData?.text ?? "";
    if (newText != "" && !clips.any((x) => x.copiedText == newText)) {
      addNewClip(newText);
    }
  }

  void addNewClip(String text) async {
    var updatedClips = await _manager.saveClip(text);
    setState(() {
      clips = updatedClips;
    });
  }

  openSettings() async {
    await WindowManager.instance.setSize(const Size(500, 500));
    WindowManager.instance.setTitleBarStyle(TitleBarStyle.normal);
    await WindowManager.instance.setAlignment(Alignment.center);
    Navigation.navigateToRoute(Routes.settings);
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingChanger>(context);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Clip It - v.0.0.0'),
        toolbarHeight: 40.0, // add this line
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
      body: Center(
          child: Column(
        children: [
          // Center(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       // Padding(
          //       //   padding: const EdgeInsets.all(8.0),
          //       //   child: ElevatedButton(
          //       //     child: const Text('start'),
          //       //     onPressed: () {
          //       //       clipboardWatcher.start();
          //       //     },
          //       //   ),
          //       // ),
          //       // ElevatedButton(
          //       //   child: const Text('stop'),
          //       //   onPressed: () {
          //       //     clipboardWatcher.stop();
          //       //   },
          //       // ),
          //     ],
          //   ),
          // ),
          Expanded(
            child: ListView(
                children: [...clips.map((clip) => ClipItemWidget(clip: clip))]),
          )
        ],
      )),
    );
  }
}
