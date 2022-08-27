import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

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
   String color;

  ClipTag(this.label, this.datetime,this.color,this.id);

}
