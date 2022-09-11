import 'package:hive_flutter/hive_flutter.dart';

part 'settings.model.g.dart';

@HiveType(typeId: 3, adapterName: "SettingsAdapter")
class SettingsModel extends HiveObject {
  @HiveField(0)
  bool darkMode = false;
  @HiveField(1)
  bool windowMode = false;
  @HiveField(2)
  int primaryColor;
  @HiveField(3)
  int secondaryColor;
  @HiveField(4)
  bool alwaysOnTop;
  @HiveField(5)
  bool dockToSide;
  @HiveField(6)
  bool launchAtStartup;
  @HiveField(7)
  bool hideClipboardAfterCopy;
  @HiveField(8, defaultValue: false)
  bool showQuickSelect;

  SettingsModel(this.alwaysOnTop, this.dockToSide, this.launchAtStartup,
      this.darkMode, this.primaryColor, this.secondaryColor, this.hideClipboardAfterCopy, this.showQuickSelect);
}
