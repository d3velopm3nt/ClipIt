import 'package:flutter/widgets.dart';
import 'package:flutter_my_clipboard/settings/contracts/settings_service.interface.dart';


class AppConfig extends InheritedWidget {
 final SettingsServiceInterface settings;
  // a valid inherited widget requires a `Widget child`
  const AppConfig({
    Key? key,
    required this.settings,
    required Widget child,
  }) : super(key: key, child: child);

  // this is a helper method we usually add to an inherited widget
  // this page has a great video explanation:
  // https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html
  static AppConfig? of(BuildContext context) =>
      // dependOnInheritedWidgetOfExactType allows the consumer to use context to
      // access the AppConfig by traversing up the widget tree. As long as our widget
      // tree has an AppConfig, a value will be returned
      context.dependOnInheritedWidgetOfExactType<AppConfig>();

  // NOTE The child widget doesn't necessarily have to be rebuilt every time its ancestor is rebuilt.
  // If the logic inside updateShouldNotify determines that the descendant widgets needs to be
  // updated, it will be notified and rebuilt.
  @override
  bool updateShouldNotify(_) => false;
}
