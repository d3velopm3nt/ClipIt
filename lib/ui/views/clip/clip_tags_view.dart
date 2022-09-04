import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/services/clip_tag_service.dart';
import 'package:flutter_my_clipboard/ui/widgets/tag/clip_tag_setup.dart';
import 'package:provider/provider.dart';

import '../../../models/cliptag.model.dart';
import '../../widgets/tag/add_new_tag_widget.dart';
import '../../widgets/tag/tag_card_widget.dart';

enum ViewState { list, setup, selected }

class ClipTagsView extends StatefulWidget {
  const ClipTagsView({Key? key}) : super(key: key);

  @override
  State<ClipTagsView> createState() => _ClipTagsViewState();
}

class _ClipTagsViewState extends State<ClipTagsView> {
  late ClipTagService tagManager;
  ViewState currentState = ViewState.list;
  ClipTag editTag = ClipTag("", "", 0, "");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tagManager = Provider.of<ClipTagService>(context);
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(children: [
              //Add New Tag
              Visibility(
                  visible: currentState == ViewState.list ? true : false,
                  child: AddNewTagWidget(
                    onPressed: () {
                      setState(() {
                        editTag = ClipTag("", "", 0, "");
                        currentState = ViewState.setup;
                      });
                    },
                  )),
              //Tag List
              Visibility(
                visible: currentState == ViewState.list ? true : false,
                child: Expanded(
                    child: ListView(shrinkWrap: true, children: [
                  ...tagManager.tags.map((tag) => TagCard(
                        tag: tag,
                        showClips: false,
                        onPressed: (tag) {
                          editTag = tag;
                         setState(() {
                           currentState = ViewState.selected; 
                         });
                        },
                        onEdit: () {
                          setState(() {
                            editTag = tag;
                            currentState = ViewState.setup;
                          });
                        },
                      ))
                ])),
              ),
              //Tag Setup
              Visibility(
                visible: currentState == ViewState.setup ? true : false,
                child: ClipTagSetup(
                    onClosed: (closed) {
                      setState(() {
                        currentState = ViewState.list;
                      });
                    },
                    tag: editTag),
              ),
              //Tag Selected View
              Visibility(
                  visible: currentState == ViewState.selected ? true : false,
                  child: Column(children: [
                    buildSelectedTagTitle(context),
                    TagCard(
                        tag: editTag,
                        showClips: true,
                        onPressed: (tag) {},
                        onEdit: () {
                          setState(() {
                            editTag = editTag;
                            currentState = ViewState.setup;
                          });
                        })
                  ]))
            ])));
  }

  buildSelectedTagTitle(BuildContext context) {
    return Card(
        child: Center(
            child: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              currentState = ViewState.list;
            });
          },
        ),
        const Text("Tag Selected")
      ],
    )));
  }
}
