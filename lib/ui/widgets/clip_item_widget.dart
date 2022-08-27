import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../models/clipitem.model.dart';
import '../../navigation/clip.navigation.dart';
import '../../services/clip_manager_service.dart';
import '../../services/clip_tag_service.dart';
import '../../services/datetime_service.dart';
import '../../theme/theme_changer.dart';
import 'tag_badge_widget.dart';

// This is the type used by the popup menu below.
enum Menu { favorite, tag, group, delete }

class ClipItemWidget extends StatelessWidget {
  final ClipItem clip;
  ClipItemWidget({Key? key, required this.clip}) : super(key: key);
  final bool latest = false;

  late ClipManager manager;
  late ThemeChanger theme;
  @override
  Widget build(BuildContext context) {
    manager = Provider.of<ClipManager>(context);
    final tagManager = Provider.of<ClipTagService>(context);
    theme = Provider.of<ThemeChanger>(context);
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          var snackBar = copyToClipboard();
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                Expanded(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpandableText(clip.copiedText,
                          maxLines: 3,
                          expandOnTextTap: true,
                          collapseOnTextTap: true,
                          expandText: '',
                          collapseText: ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(children: [
                        Wrap(children: [
                          ...clip.tags.map((id) =>
                              TagBadgeWidget(tag: tagManager.getTagById(id)))
                        ])
                      ]),
                    ),
                  ]),
                ),
                dropdownSideMenu()
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
              manager.updateClipFavorite(clip);
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

  dropdownSideMenu() {
    return PopupMenuButton<Menu>(
      splashRadius:20,
        // Callback that sets the selected popup menu item.
        onSelected: (Menu item) {
          switch (item) {
            case Menu.tag:
              ClipNavigation.navigateToRoute(ClipRoutes.tagSelector,
                  args: clip);
              break;
            case Menu.favorite:
              ClipNavigation.navigateToRoute(ClipRoutes.favorites);
              break;
            case Menu.group:
              // TODO: Handle this case.
              break;
            case Menu.delete:
              // TODO: Handle this case.
              break;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              PopupMenuItem<Menu>(
                value: Menu.favorite,
                child: buildMenuItem('Favorite', Icons.favorite),
              ),
              PopupMenuItem<Menu>(
                value: Menu.tag,
                child: buildMenuItem('Tags', Icons.local_offer_outlined),
              ),
              PopupMenuItem<Menu>(
                value: Menu.group,
                child: buildMenuItem('Group', Icons.group),
              ),
              PopupMenuItem<Menu>(
                value: Menu.delete,
                child: buildMenuItem('Delete', Icons.delete),
              ),
            ]);
  }

  buildMenuItem(String name, IconData icon) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(right: 3),
        child: Icon(icon),
      ),
      Text(name)
    ]);
  }

  deleteClip() {
    manager.deleteClip(clip);
    return showSnackBar("Clip Deleted");
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
