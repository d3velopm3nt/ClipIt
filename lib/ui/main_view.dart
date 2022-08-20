import 'package:flutter/material.dart';

import '../app/app.navigation.dart';

class MainWindow extends StatefulWidget {
  const MainWindow({Key? key}) : super(key: key);

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
          key: Navigation.mainAppNav,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) =>
              Navigation.navigationRoutes(settings.name, settings.arguments),
        ),
    );
  }
}