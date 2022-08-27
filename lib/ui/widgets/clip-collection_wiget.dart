import 'package:flutter/material.dart';
import '../../services/datetime_service.dart';
import 'title_desc_widget.dart';
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
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 199, 235, 233)),
                    child: Text(
                      widget.clips.length.toString(),
                      style: const TextStyle(
                          fontSize: 15, color: Color.fromARGB(255, 94, 89, 89)),
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
