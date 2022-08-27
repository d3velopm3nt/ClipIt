import 'package:flutter_my_clipboard/settings/models/settings.model.dart';

import '../contracts/settings_service.interface.dart';

class SettingsService implements SettingsServiceInterface {

  final SettingsModel _settings = SettingsModel();
  @override
  SettingsModel get appSettings => _settings;

  @override
  Future<SettingsModel> loadSettings() {
    throw UnimplementedError();
  }
}
