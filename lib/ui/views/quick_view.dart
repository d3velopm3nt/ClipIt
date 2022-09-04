import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/widgets/clip/clip_item_widget.dart';
import 'package:provider/provider.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';
import '../../navigation/app.navigation.dart';
import '../../navigation/clip.navigation.dart';
import '../../services/clip_manager_service.dart';
import '../../theme/theme_changer.dart';
import '../display_manager.dart';
import '../widgets/shared/title_desc_widget.dart';

class QuickView extends StatelessWidget {
  const QuickView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    final manager = Provider.of<ClipManager>(context);
    return Column(children: [
      Container(
        color: theme.getTheme.primaryColor,
        child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TitleDesc(
                    title: 'Quick Select',
                    titleStyle: TextStyle(fontSize: 15),
                    description: 'assign tags and groups to clip'),
              )),
              Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: IconButton(
                      splashRadius: 20,
                      onPressed: () => {onShowClipboard()},
                      icon: const Icon(Icons.aspect_ratio, size: 19))),
              Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: IconButton(
                      splashRadius: 20,
                      onPressed: () => {onClosed()},
                      icon: const Icon(Icons.close))),
            ]),
      ),
      ClipItemWidget(clip: manager.latestClip)
    ]);
  }

  onClosed() {
    AppWindow window = AppWindow();
    window.hide();
  }

  onShowClipboard() {
    AppNavigation.navigateToRoute(AppRoutes.home);
    DisplayManager.clipboardView();
  }
}
