import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../models/clipitem.model.dart';
import '../../services/clip_manager_service.dart';
import '../../services/datetime_service.dart';
import '../../theme/theme_changer.dart';

class ClipItemWidget extends StatelessWidget {
  final ClipItem clip;
  const ClipItemWidget({Key? key, required this.clip}) : super(key: key);
  final bool latest = false;
  @override
  Widget build(BuildContext context) {
    var manager = Provider.of<ClipManager>(context);
    final theme = Provider.of<ThemeChanger>(context);
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
        child: Row(
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
                    tooltip: 'Copy clip',
                    iconSize: 16,
                  ),
                  Text(DateTimeService.getDate(clip.datetime),
                      style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  Text(DateTimeService.getTime(clip.datetime),
                      style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: ExpandableText(clip.copiedText,
                      maxLines: 3,
                      expandOnTextTap: true,
                      collapseOnTextTap: true,
                      expandText: '',
                      collapseText: ''),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 2, top: 2),
              child: Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    iconSize: 18,
                    splashRadius: 20,
                    color: clip.favorite == true ? Colors.red : theme.getTheme.iconTheme.color ,
                    onPressed: () {
                      manager.updateClipFavorite(clip);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outlined),
                    iconSize: 20,
                    splashRadius: 20,
                    color: Colors.grey,
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ));
  }

  copyToClipboard() {
    ClipboardData data = ClipboardData(text: clip.copiedText);
    Clipboard.setData(data);
    return SnackBar(
      duration: const Duration(seconds:1),
      content: const Text('Copied to Clipboard'),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
  }
}
