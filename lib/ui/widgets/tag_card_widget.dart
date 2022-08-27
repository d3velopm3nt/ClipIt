import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/models/cliptag.model.dart';
import 'package:flutter_my_clipboard/ui/widgets/title_desc_widget.dart';
import 'package:provider/provider.dart';

import '../../models/clipitem.model.dart';
import '../../services/clip_manager_service.dart';
import '../../theme/theme_changer.dart';
import 'clip_item_widget.dart';

class TagCard extends StatefulWidget {
  final ClipTag tag;

  const TagCard({Key? key, required this.tag}) : super(key: key);
  @override
  State<TagCard> createState() => _TagCardState();
}

class _TagCardState extends State<TagCard> {
  bool showClips = false;
  List<ClipItem> clips = [];
  late ThemeChanger theme;
  late Color hoverColor;
  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeChanger>(context);
    final clips = Provider.of<ClipManager>(context)
        .clips
        .where((element) => element.tags.contains(widget.tag.id));
    return Card(
      child: InkWell(
        onTap: () {
          setState(() {
            showClips = showClips ? false : true;
          });
        },
        borderRadius: BorderRadius.circular(10),
        hoverColor: showClips ? theme.getTheme.cardColor : theme.getTheme.primaryColor,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: theme.getTheme.primaryColor),
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
                visible: showClips,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 310,
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
}
