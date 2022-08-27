import 'package:flutter/material.dart';

import '../../models/cliptag.model.dart';

class TagBadgeWidget extends StatefulWidget {
  final ClipTag tag ;
  TagBadgeWidget({Key? key, required this.tag}) : super(key: key);

  @override
  State<TagBadgeWidget> createState() => _TagBadgeWidgetState();
}

class _TagBadgeWidgetState extends State<TagBadgeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: const EdgeInsets.only(right:5),
      //padding : const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
      color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom:0),
        child: Text(widget.tag.label,style: const TextStyle(
          fontSize: 11,
        )),
      )
    );
  }
}