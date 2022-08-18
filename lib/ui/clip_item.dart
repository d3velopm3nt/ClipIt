import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../services/datetime-service.dart';

class ClipItem extends StatelessWidget {
  final String copiedText;
  final String datetime;
  const ClipItem({Key? key, required this.copiedText, required this.datetime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:  Card(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
          child:  Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(DateTimeService.getDate(datetime),style: const TextStyle(fontSize: 11,color: Colors.grey)),
                    Text(DateTimeService.getTime(datetime),style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: ExpandableText(
                      copiedText,
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
}
