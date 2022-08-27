import 'package:flutter/material.dart';
import '../../navigation/app.navigation.dart';

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
          key: AppNavigation.nav,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings route) =>
              AppNavigation.navigationRoutes(route.name, route.arguments),
        ),
    );
  }
}