import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/models/cliptag.model.dart';
import 'package:flutter_my_clipboard/navigation/clip.navigation.dart';
import 'package:provider/provider.dart';
import '../../models/clipitem.model.dart';
import '../../services/clip_manager_service.dart';
import '../../services/clip_tag_service.dart';
import '../widgets/tag_select_widget.dart';
import '../widgets/title_desc_widget.dart';

class TagSelectorView extends StatefulWidget {
  final ClipItem item;
  const TagSelectorView({Key? key, required this.item}) : super(key: key);

  @override
  State<TagSelectorView> createState() => _TagSelectorViewState();
}

class _TagSelectorViewState extends State<TagSelectorView> {
  late ClipTagService tagManager;
  late ClipManager clipManager;

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
    clipManager = Provider.of<ClipManager>(context);
    return Card(
        elevation: 5,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(Icons.local_offer_outlined),
                        ),
                        TitleDesc(
                          title: "Select Tags",
                          titleStyle: TextStyle(fontSize: 20),
                        ),
                      ]),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          shape: BoxShape.rectangle,
                          color: const Color.fromARGB(255, 245, 242, 242),
                        ),
                        child: IconButton(
                            splashRadius: 20,
                            color: Colors.black,
                            onPressed: () => {ClipNavigation.previousPage()},
                            icon: const Icon(Icons.arrow_back_rounded)),
                      ))
                ],
              ),
              Expanded(child: ListView(children: [
              ...tagManager.tags.map((tag) => TagSelectWidget(
                    tag: tag,
                    selected: widget.item.tags.contains(tag.id) ? true : false ,
                    onSelected: (selected) {
                      updateClipTags(tag, selected);
                    },
                  ))
              ]),)
            ],
          ),
        ));
  }

  updateClipTags(ClipTag tag, bool selected) {
    var item = widget.item;
    if (selected) {
      if(!item.tags.contains(tag.id)){
      item.tags.add(tag.id);
      }
    } else {
      if(item.tags.contains(tag.id)){
      item.tags.remove(tag.id);
      }
    }
    clipManager.updateClipTags(widget.item);
  }
}
