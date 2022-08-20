import '../../models/settings.model.dart';

abstract class SettingsServiceInterface {
  Future<SettingsModel> loadSettings();
  SettingsModel get appSettings;
}
