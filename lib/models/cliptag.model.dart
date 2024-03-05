import 'package:hive/hive.dart';

part 'cliptag.model.g.dart';

@HiveType(typeId: 1,adapterName: "ClipTagAdapter")
class ClipTag extends HiveObject {
  @HiveField(0)
   String id;
  @HiveField(1)
   String label;
  @HiveField(2)
   String datetime;
  @HiveField(3)
   int color;

  ClipTag(this.label, this.datetime,this.color,this.id);

  Map<String, dynamic>  toJson() {
    return {
      "id": id,
      "label": label,
      "datetime": datetime,
      "color": color,
    };
  }

  factory ClipTag.fromJson(Map<String, dynamic> json) {
    return ClipTag(
      json["label"],
      json["datetime"],
      json["color"],
      json["id"],
    );
  }

}
