import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/widgets/clip/clip_item_widget.dart';
import 'package:provider/provider.dart';
import '../../../services/clip_manager_service.dart';
import '../shared/no_results_view.dart';

class ClipFavoriteView extends StatelessWidget {
  const ClipFavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var manager = Provider.of<ClipManager>(context);
    return Column(
      children: [
        Expanded(
          child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
            children: [
                 Visibility(
                visible: manager.clips.where((c) => c.favorite).isEmpty,
                child: Expanded(
                  child: NoResultsView(
                      image: "intro/favorite.png",
                      title: "No Favorites Found",
                      description:
                          "You need to make some clippets favorites to see them here"),
                ),
              ),
                Expanded(
                  child: ListView(children: [
                    ...manager.clips.where((c) => c.favorite).map((clip) => ClipItemWidget(clip: clip))
                  ]),
                )
            ],
          ),
              )),
        ),
      ],
    );
  }
}