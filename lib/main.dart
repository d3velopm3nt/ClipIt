import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard_watcher/clipboard_watcher.dart';

import 'services/file-service.dart';
import 'ui/clip_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clip It Desktop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Clip It - Monitor'),
    );
  }
}

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
  int _counter = 0;
  List<String> clips = [];
    FileService fileService = FileService();
  @override
  void initState() {
    clipboardWatcher.addListener(this);
    super.initState();
  }

  @override
  void onClipboardChanged() async {
    ClipboardData? newClipboardData =
        await Clipboard.getData(Clipboard.kTextPlain);
    var newText = newClipboardData?.text ?? "";
    if (newText != "" && !clips.contains(newText)) {
      addNewClip(newText);
    }
  }

  void addNewClip(String text) {
    fileService.saveText(text);
    setState(() {
      clips.add(text);
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
      ),
      body: Center(
          child: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                child: const Text('start'),
                onPressed: () {
                  clipboardWatcher.start();
                },
            ),
              ),
            ElevatedButton(
              child: const Text('stop'),
              onPressed: () {
                clipboardWatcher.stop();
              },
            ),
              ],
            ),
          ),
         
          Expanded(
            child: ListView(
                children: [...clips.map((clip) => ClipItem(copiedText: clip,datetime:DateTime.now().toString(),))]),
          )
        ],
      )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
