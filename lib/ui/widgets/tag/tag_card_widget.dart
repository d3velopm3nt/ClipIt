import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/models/cliptag.model.dart';
import 'package:flutter_my_clipboard/ui/widgets/shared/confirm_dialog.dart';
import 'package:flutter_my_clipboard/ui/widgets/shared/title_desc_widget.dart';
import 'package:provider/provider.dart';

import '../../../models/clipitem.model.dart';
import '../../../services/clip_manager_service.dart';
import '../../../services/clip_tag_service.dart';
import '../../../theme/theme_changer.dart';
import '../clip/clip_item_widget.dart';

class TagCard extends StatefulWidget {
  final ClipTag tag;
  final Function() onEdit;
  final Function(ClipTag) onPressed;
  final bool showClips;
  TagCard(
      {Key? key,
      required this.tag,
      required this.onEdit,
      required this.onPressed,
      required this.showClips})
      : super(key: key);
  @override
  State<TagCard> createState() => _TagCardState();
}

class _TagCardState extends State<TagCard> {
  List<ClipItem> clips = [];
  late ThemeChanger theme;
  ClipTagService tagManager = ClipTagService();
  ClipManager clipManager = ClipManager();
  late Color hoverColor;
  bool hover = false;
  bool showDeleteDialog = false;
  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeChanger>(context);
    tagManager = Provider.of<ClipTagService>(context);
    clipManager = Provider.of<ClipManager>(context);
    final clips = clipManager.clips
        .where((element) => element.tags.contains(widget.tag.id));
    return Card(
      child: InkWell(
        onTap: () {
          setState(() {
            if (clips.isEmpty) return;
            
            widget.onPressed(widget.tag);
            
          });
        },
        onHover: (hovering) => {
          setState(() {
            hover = hovering;
          })
        },
        borderRadius: BorderRadius.circular(8),
        hoverColor: widget.showClips
            ? theme.getTheme.cardColor
            : widget.tag.color != 0
                ? Color(widget.tag.color)
                : theme.getTheme.primaryColor,
        mouseCursor: MaterialStateMouseCursor.clickable,
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.local_offer_outlined),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: TitleDesc(
                        title: widget.tag.label,
                        titleStyle: const TextStyle(fontSize: 15),
                        description: ''),
                  )),
                  Visibility(
                      visible: hover,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                widget.onEdit();
                              },
                              icon: const Icon(Icons.edit, size: 20),
                              splashRadius: 20,
                              tooltip: 'Edit Tag'),
                          IconButton(
                              onPressed: () {
                                _delete(context);
                              },
                              icon: const Icon(Icons.delete, size: 20),
                              splashRadius: 20,
                              tooltip: 'Remove Tag'),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: widget.tag.color != 0
                              ? Color(widget.tag.color)
                              : theme.getTheme.primaryColor),
                      child: Text(
                        clips.length.toString(),
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 243, 238, 238)),
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: widget.showClips,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height -225,
                  child: ListView(shrinkWrap: true, children: [
                    ...clips.map((clip) => ClipItemWidget(clip: clip)),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return ConfirmDailog(
              onConfirm: (confirm) async => {
                    if (confirm)
                      {
                        await clipManager.removeClipTags(widget.tag.id),
                        await tagManager.deleteTag(widget.tag)
                      },
                  });
        });
  }
}
