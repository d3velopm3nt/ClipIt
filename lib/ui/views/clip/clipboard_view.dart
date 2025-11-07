import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/app.notification.dart';
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
  late ClipManager manager;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    setState(() {
      _currentTabIndex = _tabController.index;
    });
    // Clear search when switching tabs
    searchController.clear();

    // Initialize archived clips if switching to archived tab
    if (_currentTabIndex == 1) {
      manager.searchArchivedClips('');
    } else {
      _performSearch('');
    }
  }

  void _performSearch(String text) {
    if (_currentTabIndex == 0) {
      // Active clips tab
      manager.searchClips(text);
    } else {
      // Archived clips tab
      manager.searchArchivedClips(text);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    manager = Provider.of<ClipManager>(context);
    tagManager = Provider.of<ClipTagService>(context);
    //hotKeyService = Provider.of<HotKeyService>(context);
    return Center(
        child: Column(
      children: [
        Consumer<ClipManager>(
          builder: (context, manager, child) => TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Active Clips'),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        manager.filteredList.length.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Archived'),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        manager.getFilteredArchivedClips().length.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: searchController,
                    onChanged: _performSearch,
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
              if (_currentTabIndex == 1) ...[
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _showClearArchiveConfirmation(context),
                  icon: const Icon(Icons.delete_sweep, color: Colors.red),
                  tooltip: 'Clear all archived clips',
                  splashRadius: 20,
                ),
              ],
            ],
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
              _buildArchivedClipList(manager.getFilteredArchivedClips()),
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
    final hasSearchText = searchController.text.isNotEmpty;
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
                title: hasSearchText ? "No archived clips match your search" : "No archived clips",
                description: hasSearchText
                    ? "Try a different search term"
                    : "Archived clips will appear here when the active clip limit is exceeded"),
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
                          onPressed: () => _showRestoreConfirmation(context, clip),
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
                          onPressed: () => _showDeleteConfirmation(context, clip),
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

  void _showRestoreConfirmation(BuildContext context, clip) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Restore Clip'),
          content: const Text('Are you sure you want to restore this clip to active clips?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Provider.of<ClipManager>(context, listen: false).restoreClip(clip);
                // Refresh archived clips to update the list immediately
                manager.searchArchivedClips(searchController.text);
              },
              child: const Text('Restore'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, clip) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Delete Archived Clip'),
          content: const Text('Are you sure you want to permanently delete this archived clip? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Provider.of<ClipManager>(context, listen: false).deleteArchivedClip(clip);
                // Refresh archived clips to update the list immediately
                manager.searchArchivedClips(searchController.text);
              },
              child: const Text('Delete'),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }

  void _showClearArchiveConfirmation(BuildContext context) {
    final archivedCount = manager.getArchivedClips().length;

    if (archivedCount == 0) {
      AppNotification.infoNotification(
        'No Archived Clips',
        'There are no archived clips to clear'
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Clear All Archived Clips'),
          content: Text('Are you sure you want to permanently delete all $archivedCount archived clips? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Provider.of<ClipManager>(context, listen: false).clearAllArchivedClips();
                // Clear search and refresh
                searchController.clear();
                manager.searchArchivedClips('');
              },
              child: const Text('Clear All'),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }
}
