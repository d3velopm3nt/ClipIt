import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/services/clip_tag_service.dart';
import 'package:flutter_my_clipboard/ui/widgets/tag/clip_tag_setup.dart';
import 'package:provider/provider.dart';

import '../../../models/cliptag.model.dart';
import '../../../navigation/clip.navigation.dart';
import '../../../services/clip_manager_service.dart';
import '../../widgets/tag/add_new_tag_widget.dart';
import '../../widgets/tag/tag_card_widget.dart';
import '../shared/no_results_view.dart';

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
  final filterController = TextEditingController();
  List<ClipTag> filteredTags = [];
  @override
  void initState() {
    super.initState();
    filteredTags = [];
  }

  void filterTags(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredTags = tagManager.tags;
      } else {
        filteredTags = tagManager.tags
            .where((tag) =>
                tag.label.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    tagManager = Provider.of<ClipTagService>(context);
    final clipManager = Provider.of<ClipManager>(context);
    // Update filtered tags when tags change
    if (filterController.text.isEmpty) {
      filteredTags = tagManager.tags;
    } else {
      filteredTags = tagManager.tags
          .where((tag) =>
              tag.label.toLowerCase().contains(filterController.text.toLowerCase()))
          .toList();
    }
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(children: [
              //Filter Tags
              Visibility(
                visible: currentState == ViewState.list ? true : false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: filterController,
                      onChanged: (text) {
                        filterTags(text);
                      },
                      decoration: const InputDecoration(
                          labelText: "Search for tags...",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              //Outline border type for TextField
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 99, 99),
                                width: 3,
                              ))),
                    ),
                  ),
                ),
              ),
              const Divider(),
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
                visible: (currentState == ViewState.list && filteredTags.isNotEmpty),
                child: Expanded(
                    child: ListView(shrinkWrap: true, children: [
                  ...filteredTags.map((tag) => TagCard(
                        tag: tag,
                        showClips: false,
                        onPressed: (tag) {
                          ClipNavigation.navigateToRoute(
                              ClipRoutes.clipCollection,
                              args: {
                                "clips": clipManager.clips
                                    .where((element) =>
                                        element.tags.contains(tag.id))
                                    .toList(),
                                "title": tag.label,
                                "color": tag.color > 0 ? Color(tag.color) : null
                                });
                          //  setState(() {
                          //    currentState = ViewState.selected;
                          //  });
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
               Visibility(
                visible: (currentState == ViewState.list && tagManager.tags.isEmpty),
                child: Expanded(
                  child: NoResultsView(
                      image: "intro/tag.png",
                      title: "No Tags Created",
                      description:
                          "Add new tags to assign to clippets"),
                ),
              ),
              Visibility(
                visible: (currentState == ViewState.list && filteredTags.isEmpty && tagManager.tags.isNotEmpty),
                child: Expanded(
                  child: NoResultsView(
                      image: "intro/tag.png",
                      title: "No tags match your search",
                      description:
                          "Try a different search term"),
                ),
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
