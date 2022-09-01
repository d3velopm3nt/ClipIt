import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_my_clipboard/services/hotkey_service.dart';
import 'package:provider/provider.dart';
import '../../../app/app.notification.dart';
import '../../../models/clipitem.model.dart';
import '../../../navigation/clip.navigation.dart';
import '../../../services/clip_manager_service.dart';
import '../../../services/clip_tag_service.dart';
import '../../../services/datetime_service.dart';
import '../../../theme/theme_changer.dart';
import '../shared/record_hotkey_dialog.dart';
import '../tag/tag_badge_widget.dart';

// This is the type used by the popup menu below.
enum Menu { favorite, tag, group, delete, hotkey }

class ClipItemWidget extends StatelessWidget {
  final ClipItem clip;
  ClipItemWidget({Key? key, required this.clip}) : super(key: key);
  final bool latest = false;

  late ClipManager manager;
  late ThemeChanger theme;
  late HotKeyService hotkeyService;
  @override
  Widget build(BuildContext context) {
    manager = Provider.of<ClipManager>(context);
    final tagManager = Provider.of<ClipTagService>(context);
    theme = Provider.of<ThemeChanger>(context);
    hotkeyService = Provider.of<HotKeyService>(context);
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
              color: (manager.latestClip == clip
                  ? theme.getTheme.secondaryHeaderColor
                  : theme.getTheme.focusColor),
              width: 2.0),
        ),
        shadowColor: (manager.latestClip == clip
            ? theme.getTheme.secondaryHeaderColor
            : Colors.grey),
        elevation: (manager.latestClip == clip ? 6 : 1),
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            var snackBar = copyToClipboard();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          icon: const Icon(Icons.copy),
                          splashRadius: 20,
                          tooltip: 'Copy clip',
                          iconSize: 16,
                        ),
                        Text(DateTimeService.getDate(clip.datetime),
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey)),
                        Text(DateTimeService.getTime(clip.datetime),
                            style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Copied Text
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 2, bottom: 8, right: 2),
                          child: ExpandableText(clip.copiedText,
                              maxLines: 3,
                              expandOnTextTap: true,
                              collapseOnTextTap: true,
                              expandText: '',
                              collapseText: ''),
                        ),
                        //Tag Bages
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 2, bottom: 8, right: 2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                                spacing: 1,
                                alignment: WrapAlignment.start,
                                //crossAxisAlignment: WrapCrossAlignment.start,
                                children: [
                                  ...clip.tags.map((id) => TagBadgeWidget(
                                      tag: tagManager.getTagById(id)))
                                ]),
                          ),
                        ),
                      ]),
                ),
                dropdownSideMenu(context)
              ],
            ),
          ],
        ));
  }

  simpleSideMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2, top: 2),
      child: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.favorite),
            iconSize: 18,
            splashRadius: 20,
            color: clip.favorite == true
                ? Colors.red
                : theme.getTheme.iconTheme.color,
            onPressed: () {
              updateFavorite();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outlined),
            iconSize: 20,
            splashRadius: 20,
            color: Colors.grey,
            onPressed: () {
              var snackbar = deleteClip();
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            },
          )
        ],
      ),
    );
  }

  dropdownSideMenu(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          PopupMenuButton<Menu>(
              splashRadius: 20,
              // Callback that sets the selected popup menu item.
              onSelected: (Menu item) {
                switch (item) {
                  case Menu.tag:
                    ClipNavigation.navigateToRoute(ClipRoutes.tagSelector,
                        args: clip);
                    break;
                  case Menu.favorite:
                    updateFavorite();
                    break;
                  case Menu.hotkey:
                    _handleClickRegisterNewHotKey(context);
                    break;
                  case Menu.group:
                    break;
                  case Menu.delete:
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                    PopupMenuItem<Menu>(
                      value: Menu.favorite,
                      child:
                          buildMenuItem('Favorite', Icons.favorite, Colors.red),
                    ),
                    PopupMenuItem<Menu>(
                      value: Menu.hotkey,
                      child: buildMenuItem(
                          'HotKey',
                          Icons.local_fire_department,
                          const Color.fromARGB(255, 235, 118, 8)),
                    ),
                    PopupMenuItem<Menu>(
                      value: Menu.tag,
                      child: buildMenuItem(
                          'Tags', Icons.local_offer_outlined, null),
                    ),
                    PopupMenuItem<Menu>(
                      value: Menu.group,
                      child: buildMenuItem('Group', Icons.group, null),
                    ),
                    PopupMenuItem<Menu>(
                      value: Menu.delete,
                      child: buildMenuItem('Delete', Icons.delete, null),
                    ),
                  ]),
          Visibility(
            visible: clip.favorite ? true : false,
            child: IconButton(
              icon: const Icon(Icons.favorite),
              iconSize: 18,
              splashRadius: 20,
              color: clip.favorite == true
                  ? Colors.red
                  : theme.getTheme.iconTheme.color,
              onPressed: () {
                updateFavorite();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleClickRegisterNewHotKey(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return RecordHotKeyDialog(
            onHotKeyRecorded: (newHotKey) => {
                  hotkeyService.registerHotKey(newHotKey,clip.id.toString()),
                  AppNotification.saveNotification("New HotKey has been assign", "Now you can use the hot key to copy and paste the clip text")
                });
      },
    );
  }

  buildMenuItem(String name, IconData icon, Color? iconColor) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(right: 3, left: 5),
        child: Icon(icon, color: iconColor ?? theme.getTheme.iconTheme.color),
      ),
      Text(name, style: const TextStyle(fontSize: 15))
    ]);
  }

  deleteClip() {
    manager.deleteClip(clip);
    return showSnackBar("Clip Deleted");
  }

  updateFavorite() async {
    clip.favorite = clip.favorite ? false : true;
    await manager.updateClip(clip);
  }

  showSnackBar(String message) {
    return SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(message),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
  }

  copyToClipboard() {
    ClipboardData data = ClipboardData(text: clip.copiedText);
    Clipboard.setData(data);
    return showSnackBar('Copied to Clipboard');
  }
}
