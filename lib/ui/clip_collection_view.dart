import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/widgets/clip-collection_wiget.dart';
import 'package:provider/provider.dart';

import '../services/clip_manager_service.dart';
import 'widgets/clip_item_widget.dart';

class ClipCollectionView extends StatelessWidget {
  const ClipCollectionView({Key? key}) : super(key: key);

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
              //...manager.clips.map((clip) => ClipItemWidget(clip: clip))
              ClipCollection(
                title: 'Today',
                description: DateTime.now().toString(),
                clips: manager.getByDate(DateTime.now()).map((clip) => ClipItemWidget(clip: clip)).toList()),
               ClipCollection(
                title: 'Yesterday', 
                description: DateTime.now().subtract(const Duration(days:1)).toString(),
                clips: manager.getByDate(DateTime.now().subtract(const Duration(days:1))).map((clip) => ClipItemWidget(clip: clip)).toList()
                )
            ]),
          )
      ],
    ),
        ));
  }
}