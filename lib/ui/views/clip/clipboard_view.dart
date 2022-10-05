import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../navigation/navigation_manager.dart';
import '../../../services/clip_manager_service.dart';
import '../../../services/clip_tag_service.dart';
import '../../widgets/clip/clip_item_widget.dart';
import '../shared/no_results_view.dart';

class ClipboardView extends StatelessWidget {
  ClipboardView({Key? key}) : super(key: key);

  final searchController = TextEditingController();
  final navigation = NavigationManager();
  ClipTagService tagManager = ClipTagService();

  @override
  Widget build(BuildContext context) {
    var manager = Provider.of<ClipManager>(context);
    tagManager = Provider.of<ClipTagService>(context);
    //hotKeyService = Provider.of<HotKeyService>(context);
    return Center(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: searchController,
              onChanged: ((text) {
                manager.searchClips(text);
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
        const Divider(),
        Expanded(
          child: Column(
            children: [
              Visibility(
                visible: manager.filteredList.isNotEmpty,
                child: Expanded(
                  child: ListView(children: [
                    ...manager.filteredList
                        .map((clip) => ClipItemWidget(clip: clip))
                  ]),
                ),
              ),
              Visibility(
                visible: !manager.filteredList.isNotEmpty,
                child: Expanded(
                  child: NoResultsView(
                      image: "intro/copy.png",
                      title: "No clippets saved",
                      description:
                          "Copy something to add it to your clipboard"),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
