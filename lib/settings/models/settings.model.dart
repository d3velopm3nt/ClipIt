
class SettingsModel {
  bool darkTheme = false;
  late bool alwaysOnTop;
  late String dockToSide;
  late bool launchAtStartup;

  SettingsModel(
      );

  SettingsModel.fromJson(Map<String, dynamic> json)
      : darkTheme = json["darkTheme"],
        alwaysOnTop = json["alwaysOnTop"],
        dockToSide = json["dockToSide"],
        launchAtStartup = json["launchAtStartup"];

  Map toJson() => {
        'darkTheme': darkTheme,
        'alwaysOnTop': alwaysOnTop,
        'dockToSide': dockToSide,
        'launchAtStartup': launchAtStartup,
      };
}
