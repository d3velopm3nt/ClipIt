import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/widgets/clip_item_widget.dart';
import 'package:provider/provider.dart';

import '../services/clip_manager_service.dart';

class ClipFavoriteView extends StatelessWidget {
  const ClipFavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var manager = Provider.of<ClipManager>(context);
    return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
      children: [
          
          Expanded(
            child: ListView(children: [
              ...manager.clips.where((c) => c.favorite).map((clip) => ClipItemWidget(clip: clip))
            ]),
          )
      ],
    ),
        ));
  }
}