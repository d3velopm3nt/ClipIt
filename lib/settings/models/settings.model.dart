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
  @HiveField(9, defaultValue: false)
  bool setupDone;

  SettingsModel(
      this.alwaysOnTop,
      this.dockToSide,
      this.launchAtStartup,
      this.darkMode,
      this.primaryColor,
      this.secondaryColor,
      this.hideClipboardAfterCopy,
      this.showQuickSelect,
      this.setupDone);

  Map<String, dynamic> toJson() {
    return {
      "darkMode": darkMode,
      "windowMode": windowMode,
      "primaryColor": primaryColor,
      "secondaryColor": secondaryColor,
      "alwaysOnTop": alwaysOnTop,
      "dockToSide": dockToSide,
      "launchAtStartup": launchAtStartup,
      "hideClipboardAfterCopy": hideClipboardAfterCopy,
      "showQuickSelect": showQuickSelect,
      "setupDone": setupDone,
    };
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      json["alwaysOnTop"],
      json["dockToSide"],
      json["launchAtStartup"],
      json["darkMode"],
      json["primaryColor"],
      json["secondaryColor"],
      json["hideClipboardAfterCopy"],
      json["showQuickSelect"],
      json["setupDone"],
    );
  }
}
