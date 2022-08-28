import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/services/clip_tag_service.dart';
import 'package:flutter_my_clipboard/ui/widgets/clip_tag_setup.dart';
import 'package:provider/provider.dart';

import '../../models/cliptag.model.dart';
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
  ClipTag editTag = ClipTag("", "", 0, "");
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
                  child: AddNewTagWidget(
                    onPressed: () {
                      setState(() {
                        editTag = ClipTag("", "", 0, "");
                        showSetup = true;
                      });
                    },
                  )),
              Visibility(
                visible: showSetup,
                child: ClipTagSetup(
                    onClosed: (closed) {
                      setState(() {
                        showSetup = closed;
                      });
                    },
                    tag: editTag),
              ),
              Visibility(
                visible: !showSetup,
                child: Expanded(
                    child: ListView(shrinkWrap: true,children: [
                  ...tagManager.tags.map((tag) => TagCard(
                        tag: tag,
                        onEdit: () {
                          setState(() {
                            editTag = tag;
                            showSetup = true;
                          });
                        },
                      ))
                ])),
              )
            ])));
  }
}
