import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_loader/screen_loader.dart';

import '../../../models/clipitem.model.dart';
import '../../../navigation/clip.navigation.dart';
import '../../../theme/theme_changer.dart';
import '../../widgets/clip/clip_item_widget.dart';

class ClipCollectionView extends StatefulWidget with ScreenLoader {
  final String title;
  final Color? color;
  List<ClipItem> clips;
  ClipCollectionView(
      {Key? key, required this.title, required this.clips, this.color})
      : super(key: key);

  @override
  State<ClipCollectionView> createState() => _ClipCollectionViewState();
}

class _ClipCollectionViewState extends State<ClipCollectionView> {
  final searchController = TextEditingController();
  late List<ClipItem> _allClips;

  @override
  void initState() {
    _allClips = widget.clips;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Column(
      children: [
        Card(
            child: Center(
                child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      ClipNavigation.previousPage();
                    },
                  ),
                  Text(widget.title),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.color ?? theme.getTheme.primaryColor),
                  child: Text(widget.clips.length.toString()),
                ))
          ],
        ))),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: searchController,
              onChanged: ((text) {
                setState(() {
                  if (text != "") {
                    widget.clips = _allClips;
                    widget.clips = widget.clips
                        .where((element) => element.copiedText.toLowerCase().contains(text.toLowerCase()))
                        .toList();
                  } else {
                    widget.clips = _allClips;
                  }
                });
              }),
              decoration: const InputDecoration(
                  labelText: "Search for clips...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      //Outline border type for TextFeild
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 104, 99, 99),
                        width: 3,
                      ))),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 225,
          child: ListView(shrinkWrap: true, children: [
            ...widget.clips.map((clip) => ClipItemWidget(clip: clip)),
          ]),
        ),
      ],
    );
  }
}
