import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/datetime_service.dart';
import '../../../theme/theme_changer.dart';
import '../shared/title_desc_widget.dart';
import 'clip_item_widget.dart';

class ClipCollection extends StatefulWidget {
  final String title;
  final String? description;
  final List<ClipItemWidget> clips;
  const ClipCollection(
      {Key? key,
      required this.title,
      required this.clips,
      this.description})
      : super(key: key);

  @override
  State<ClipCollection> createState() => _ClipCollectionState();
}

class _ClipCollectionState extends State<ClipCollection> {
  bool showClips = false;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Card(
      child: InkWell(
        onTap: () {
        setState(() {
          showClips = showClips ? false : true;
        });
      },
        mouseCursor: MaterialStateMouseCursor.clickable,
        child: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TitleDesc(
                      title: widget.title,
                      titleStyle: const TextStyle(fontSize: 15),
                      description:
                          DateTimeService.getDate(widget.description.toString())),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.getTheme.secondaryHeaderColor),
                    child: Text(
                      widget.clips.length.toString(),
                      style: const TextStyle(
                          fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: showClips,
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView(shrinkWrap: true, children: widget.clips),
              ),
            )
          ],
        ),
      ),
      ),
    );
  }
}
