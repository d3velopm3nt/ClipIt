import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/navigation/clip.navigation.dart';
import 'package:flutter_my_clipboard/settings/services/settings_service.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsService>(context);

    if(settings.appSettings.setupDone){
      //ClipNavigation.
    }
    return Container();
  }
}
