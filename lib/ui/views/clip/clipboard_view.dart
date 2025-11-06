import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../navigation/navigation_manager.dart';
import '../../../services/clip_manager_service.dart';
import '../../../services/clip_tag_service.dart';
import '../../../services/datetime_service.dart';
import '../../widgets/clip/clip_item_widget.dart';
import '../../widgets/tag/tag_badge_widget.dart';
import '../shared/no_results_view.dart';

class ClipboardView extends StatefulWidget {
  ClipboardView({Key? key}) : super(key: key);

  @override
  State<ClipboardView> createState() => _ClipboardViewState();
}

class _ClipboardViewState extends State<ClipboardView> with TickerProviderStateMixin {
  final searchController = TextEditingController();
  final navigation = NavigationManager();
  late TabController _tabController;
  ClipTagService tagManager = ClipTagService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var manager = Provider.of<ClipManager>(context);
    tagManager = Provider.of<ClipTagService>(context);
    //hotKeyService = Provider.of<HotKeyService>(context);
    return Center(
        child: Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active Clips'),
            Tab(text: 'Archived Clips'),
          ],
        ),
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
          child: TabBarView(
            controller: _tabController,
            children: [
              // Active Clips Tab
              _buildClipList(manager.filteredList, "No clippets saved", "Copy something to add it to your clipboard"),
              // Archived Clips Tab
              _buildArchivedClipList(manager.getArchivedClips()),
            ],
          ),
        )
      ],
    ));
  }

  Widget _buildClipList(List clips, String emptyTitle, String emptyDescription) {
    return Column(
      children: [
        Visibility(
          visible: clips.isNotEmpty,
          child: Expanded(
            child: ListView(children: [
              ...clips.map((clip) => ClipItemWidget(clip: clip))
            ]),
          ),
        ),
        Visibility(
          visible: clips.isEmpty,
          child: Expanded(
            child: NoResultsView(
                image: "intro/copy.png",
                title: emptyTitle,
                description: emptyDescription),
          ),
        )
      ],
    );
  }

  Widget _buildArchivedClipList(List archivedClips) {
    return Column(
      children: [
        Visibility(
          visible: archivedClips.isNotEmpty,
          child: Expanded(
            child: ListView(children: [
              ...archivedClips.map((clip) => _buildArchivedClipItem(clip))
            ]),
          ),
        ),
        Visibility(
          visible: archivedClips.isEmpty,
          child: Expanded(
            child: NoResultsView(
                image: "intro/copy.png",
                title: "No archived clips",
                description: "Archived clips will appear here when the active clip limit is exceeded"),
          ),
        )
      ],
    );
  }

  Widget _buildArchivedClipItem(clip) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Restore clip to active
                            Provider.of<ClipManager>(context, listen: false).restoreClip(clip);
                          },
                          icon: const Icon(Icons.restore),
                          splashRadius: 20,
                          tooltip: 'Restore clip',
                          iconSize: 16,
                        ),
                        Text(DateTimeService.getDate(clip.datetime),
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey)),
                        Text(DateTimeService.getTime(clip.datetime),
                            style: const TextStyle(fontSize: 13)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 2, bottom: 8, right: 2),
                            child: Column(
                              children: [
                                Visibility(
                                    visible: clip.secure,
                                    child: Center(
                                        child: Column(
                                      children: const [
                                        Icon(Icons.lock, size: 30),
                                      ],
                                    ))),
                                Visibility(
                                  visible: !clip.secure,
                                  child: ExpandableText(clip.copiedText,
                                      maxLines: 3,
                                      expandOnTextTap: true,
                                      collapseOnTextTap: true,
                                      expandText: '',
                                      collapseText: ''),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 2, bottom: 8, right: 2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                                spacing: 1,
                                alignment: WrapAlignment.start,
                                children: [
                                  ...clip.tags.map((id) => TagBadgeWidget(
                                      tag: tagManager.getTagById(id)))
                                ]),
                          ),
                        ),
                      ]),
                ),
                // Archive menu
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2, top: 2),
                    child: Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete_outlined),
                          iconSize: 20,
                          splashRadius: 20,
                          color: Colors.grey,
                          onPressed: () {
                            Provider.of<ClipManager>(context, listen: false).deleteArchivedClip(clip);
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
