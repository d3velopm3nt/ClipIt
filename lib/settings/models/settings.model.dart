import 'package:hive_flutter/hive_flutter.dart';

part 'settings.model.g.dart';

@HiveType(typeId: 3, adapterName: "SettingsAdapter")
class SettingsModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  dynamic value;

  SettingsModel(this.name, this.value);

  // Factory constructors for common settings
  factory SettingsModel.darkMode(bool value) => SettingsModel('darkMode', value);
  factory SettingsModel.windowMode(bool value) => SettingsModel('windowMode', value);
  factory SettingsModel.primaryColor(int value) => SettingsModel('primaryColor', value);
  factory SettingsModel.secondaryColor(int value) => SettingsModel('secondaryColor', value);
  factory SettingsModel.alwaysOnTop(bool value) => SettingsModel('alwaysOnTop', value);
  factory SettingsModel.dockToSide(bool value) => SettingsModel('dockToSide', value);
  factory SettingsModel.launchAtStartup(bool value) => SettingsModel('launchAtStartup', value);
  factory SettingsModel.hideClipboardAfterCopy(bool value) => SettingsModel('hideClipboardAfterCopy', value);
  factory SettingsModel.showQuickSelect(bool value) => SettingsModel('showQuickSelect', value);
  factory SettingsModel.setupDone(bool value) => SettingsModel('setupDone', value);

  // Backward compatibility getters/setters for when this is used as a single object
  bool get darkMode => name == 'settings' ? (value as Map<String, dynamic>)['darkMode'] ?? false : false;
  bool get windowMode => name == 'settings' ? (value as Map<String, dynamic>)['windowMode'] ?? false : false;
  int get primaryColor => name == 'settings' ? (value as Map<String, dynamic>)['primaryColor'] ?? 0 : 0;
  int get secondaryColor => name == 'settings' ? (value as Map<String, dynamic>)['secondaryColor'] ?? 0 : 0;
  bool get alwaysOnTop => name == 'settings' ? (value as Map<String, dynamic>)['alwaysOnTop'] ?? false : false;
  bool get dockToSide => name == 'settings' ? (value as Map<String, dynamic>)['dockToSide'] ?? true : true;
  bool get launchAtStartup => name == 'settings' ? (value as Map<String, dynamic>)['launchAtStartup'] ?? false : false;
  bool get hideClipboardAfterCopy => name == 'settings' ? (value as Map<String, dynamic>)['hideClipboardAfterCopy'] ?? false : false;
  bool get showQuickSelect => name == 'settings' ? (value as Map<String, dynamic>)['showQuickSelect'] ?? false : false;
  bool get setupDone => name == 'settings' ? (value as Map<String, dynamic>)['setupDone'] ?? false : false;

  set darkMode(bool val) => name == 'settings' ? (value as Map<String, dynamic>)['darkMode'] = val : null;
  set windowMode(bool val) => name == 'settings' ? (value as Map<String, dynamic>)['windowMode'] = val : null;
  set primaryColor(int val) => name == 'settings' ? (value as Map<String, dynamic>)['primaryColor'] = val : null;
  set secondaryColor(int val) => name == 'settings' ? (value as Map<String, dynamic>)['secondaryColor'] = val : null;
  set alwaysOnTop(bool val) => name == 'settings' ? (value as Map<String, dynamic>)['alwaysOnTop'] = val : null;
  set dockToSide(bool val) => name == 'settings' ? (value as Map<String, dynamic>)['dockToSide'] = val : null;
  set launchAtStartup(bool val) => name == 'settings' ? (value as Map<String, dynamic>)['launchAtStartup'] = val : null;
  set hideClipboardAfterCopy(bool val) => name == 'settings' ? (value as Map<String, dynamic>)['hideClipboardAfterCopy'] = val : null;
  set showQuickSelect(bool val) => name == 'settings' ? (value as Map<String, dynamic>)['showQuickSelect'] = val : null;
  set setupDone(bool val) => name == 'settings' ? (value as Map<String, dynamic>)['setupDone'] = val : null;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      json['name'] as String,
      json['value'],
    );
  }
}
