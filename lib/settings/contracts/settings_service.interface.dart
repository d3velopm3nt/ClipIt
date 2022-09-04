import '../../theme/theme_changer.dart';
import '../models/settings.model.dart';

abstract class SettingsServiceInterface {
  Future<void> loadSettings(ThemeChanger themeChanger);
  Future<void> saveSettings();
  SettingsModel get appSettings;
}
