import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/services/clip_tag_service.dart';
import 'package:flutter_my_clipboard/ui/widgets/clip_tag_setup.dart';
import 'package:provider/provider.dart';

import '../widgets/add_new_tag_widget.dart';
import '../widgets/tag_card_widget.dart';

class ClipTagsView extends StatefulWidget {
  const ClipTagsView({Key? key}) : super(key: key);

  @override
  State<ClipTagsView> createState() => _ClipTagsViewState();
}

class _ClipTagsViewState extends State<ClipTagsView> {
  bool showSetup = false;
  late ClipTagService tagManager;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
     await tagManager.loadTags();
    });
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tagManager = Provider.of<ClipTagService>(context);

    return Center(
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(children: [
              Visibility(
                  visible: !showSetup,
                  child: GestureDetector(
                    onTap: () => setState(() {
                      showSetup = true;
                    }),
                    child: const AddNewTagWidget(),
                  )),
              Visibility(
                visible: showSetup,
                child: ClipTagSetup(onClosed: (closed) {
                  setState(() {
                    showSetup = closed;
                  });
                }),
              ),
              Visibility(
                visible: !showSetup,
                child: Column(children: [
                  ...tagManager.tags.map((tag) => TagCard(tag: tag))
                ]),
              )
            ])));
  }
}
