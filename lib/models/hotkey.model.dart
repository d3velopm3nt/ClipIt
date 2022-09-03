import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'hotkey.model.g.dart';

@HiveType(typeId: 2, adapterName: "HotKeyAdapter")
class HotKeyModel extends HiveObject {
  @HiveField(0)
  String id = const Uuid().v4();
  @HiveField(1)
  String keyCode;
  @HiveField(2)
  List<String> modifiers;
  @HiveField(4)
  String clipId;

  HotKeyModel(this.id,this.keyCode, this.modifiers,this.clipId);
}
