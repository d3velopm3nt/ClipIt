import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/navigation/app.navigation.dart';
import 'package:hive_ui/boxes_view.dart';

import '../../services/box/boxes.dart';

class HiveView extends StatelessWidget {
  const HiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: const Text("OPEN HIVE UI"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HiveBoxesView(
                      hiveBoxes: Boxes.allBoxes,
                      onError: (String errorMessage) => {
                        print(errorMessage),
                      },
                    ),
                  ),
                );
              },
            ),
            MaterialButton(
              child: const Text("Close HIVE UI"),
              onPressed: () {
                AppNavigation.previousPage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
