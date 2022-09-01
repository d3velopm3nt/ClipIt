import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../navigation/navigation_manager.dart';
import '../../../services/clip_manager_service.dart';
import '../../../services/clip_tag_service.dart';
import '../../widgets/clip/clip_item_widget.dart';

class ClipboardView extends StatefulWidget {
  const ClipboardView({Key? key}) : super(key: key);

  @override
  State<ClipboardView> createState() => _ClipboardViewState();
}

class _ClipboardViewState extends State<ClipboardView> {
  final searchController = TextEditingController();
  final navigation = NavigationManager();
  ClipTagService tagManager = ClipTagService();
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await tagManager.loadTags();
      //  await AppLoadTest.createTags(tagManager,"TEST TAG ", 10);
    });
    
  //   WidgetsBinding.instance.endOfFrame.then((_) {
  //     print("page loaded");
  //     navigation.pageLoading(false);
  //   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var manager = Provider.of<ClipManager>(context);
    tagManager = Provider.of<ClipTagService>(context);
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
          child: ListView(children: [
            ...manager.filteredList.map((clip) => ClipItemWidget(clip: clip))
          ]),
        )
      ],
    ));
  }

}
