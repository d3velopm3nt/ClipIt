import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:clipboard_watcher/clipboard_watcher.dart';
import 'package:window_manager/window_manager.dart';
import '../models/clipitem.dart';
import '../services/clip-manager-service.dart';
import '../ui/clip_item_widget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ClipboardListener {
  List<ClipItem> clips = [];
  IconData pinnedIcon = Icons.push_pin;
  String pinnedIconTooltip = "Pin To Top";
  final ClipManager _manager = ClipManager();
  @override
  void initState() {
    clipboardWatcher.addListener(this);
      clipboardWatcher.start();
    Future.delayed(Duration.zero, () async {
      clips = await _manager.loadClips();
      setState(() {
        clips = clips;
      });
    });
    super.initState();
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
    // await WindowManager.instance.setPosition(Offset.zero);
    WindowManager.instance.setTitleBarStyle(TitleBarStyle.normal);
    await WindowManager.instance.setAlignment(Alignment.center);

    // systemTray.initSystemTray(
    //                 iconPath: getTrayImagePath('app_icon')) {
    //               systemTray.setTitle("new system tray");
    //               systemTray.setToolTip(
    //                   "How to use system tray with Flutter");
    //               systemTray.setContextMenu(menu);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        toolbarHeight: 40.0, // add this line
        actions: <Widget>[
          IconButton(
              tooltip: pinnedIconTooltip,
            icon: Icon(
              pinnedIcon,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              setState(() {
                if (pinnedIcon == Icons.push_pin) {
                  pinnedIcon = Icons.adjust;
                  WindowManager.instance.setAlwaysOnTop(true);
                  pinnedIconTooltip = "Unpin Clipboard";
                } else {
                  pinnedIcon = Icons.push_pin;
                  WindowManager.instance.setAlwaysOnTop(false);
                  pinnedIconTooltip = "Pin to Top";
                }
              });
            },
          ),
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
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: ElevatedButton(
                //     child: const Text('start'),
                //     onPressed: () {
                //       clipboardWatcher.start();
                //     },
                //   ),
                // ),
                // ElevatedButton(
                //   child: const Text('stop'),
                //   onPressed: () {
                //     clipboardWatcher.stop();
                //   },
                // ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
                children: [...clips.map((clip) => ClipItemWidget(clip: clip))]),
          )
        ],
      )),
    );
  }
}
