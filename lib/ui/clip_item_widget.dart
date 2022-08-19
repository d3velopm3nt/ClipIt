import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/clipitem.dart';
import '../services/datetime-service.dart';

class ClipItemWidget extends StatelessWidget {
  final ClipItem clip;
  const ClipItemWidget({Key? key, required this.clip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
          margin:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(DateTimeService.getDate(clip.datetime),
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey)),
                    Text(DateTimeService.getTime(clip.datetime),
                        style: const TextStyle(fontSize: 13)),
                    IconButton(
                      onPressed: () {
                        var snackBar = copyToClipboard();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: const Icon(Icons.copy),
                      tooltip: 'Copy clip',
                      iconSize: 13,
                    )
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: ExpandableText(clip.copiedText,
                        maxLines: 3,
                        expandText: 'show more',
                        collapseText: 'show less'),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  dynamic copyToClipboard() {
  ClipboardData data = ClipboardData(text: clip.copiedText);
  Clipboard.setData(data);
      return SnackBar(
        content: const Text('Copied to Clipboard'),
        action: SnackBarAction(
          label: 'Sweet',
          onPressed: () {},
        ),
      );
 
  }
}
