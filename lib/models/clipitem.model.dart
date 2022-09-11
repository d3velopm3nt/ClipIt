import 'package:hive/hive.dart';

part 'clipitem.model.g.dart';

@HiveType(typeId: 0, adapterName: "ClipItemAdapter")
class ClipItem extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String copiedText;
  @HiveField(2)
  String datetime;
  @HiveField(3, defaultValue: false)
  bool favorite;
  @HiveField(4, defaultValue: [])
  List<String> tags;
  @HiveField(5,defaultValue: false)
  bool secure;

  ClipItem(this.copiedText, this.datetime, this.favorite, this.tags, this.id,this.secure);
}
