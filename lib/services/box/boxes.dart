import 'dart:io';
import 'package:flutter_my_clipboard/models/clipitem.model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../models/cliptag.model.dart';
import '../../models/hotkey.model.dart';
import '../../settings/models/settings.model.dart';

class Boxes{

  static Box<ClipItem> get clipsBox => Hive.box<ClipItem>("clipBox");
  static Box<ClipTag> get tagsBox => Hive.box<ClipTag>("tagBox");
  static Box<HotKeyModel> get hotKeyBox => Hive.box<HotKeyModel>("hotKeyBox");
  static Box<SettingsModel> get settingsBox => Hive.box<SettingsModel>("settingsBox");

  static Future<void> load() async{
      //Start Hive with custom directory
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final clipitDir = Directory(path.join(appDocumentDir.path, 'ClipIt'));
      await clipitDir.create(recursive: true);
      await Hive.initFlutter(clipitDir.path);

      Hive.registerAdapter(ClipItemAdapter());
      Hive.registerAdapter(ClipTagAdapter());
      Hive.registerAdapter(HotKeyAdapter());
      Hive.registerAdapter(SettingsAdapter());
      await Hive.openBox<SettingsModel>("settingsBox");
      await Hive.openBox<HotKeyModel>("hotKeyBox");
      await Hive.openBox<ClipTag>("tagBox");
      await Hive.openBox<ClipItem>("clipBox");

  }

  static Map<Box<dynamic>, dynamic Function(dynamic json)> get allBoxes =>{
    clipsBox: (json) => ClipItem.fromJson(json),
    tagsBox: (json) => ClipTag.fromJson(json),
    hotKeyBox: (json) => HotKey.fromJson(json),
    settingsBox: (json) => SettingsModel.fromJson(json),
  };

// Clear all boxes
  static Future<void> clearAllBoxes() async {
    // await clipsBox.clear();
    // await tagsBox.clear();
  }
}