import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/cliptag.model.dart';
import '../../../theme/theme_changer.dart';

class TagBadgeWidget extends StatefulWidget {
  final ClipTag tag ;
  const TagBadgeWidget({Key? key, required this.tag}) : super(key: key);

  @override
  State<TagBadgeWidget> createState() => _TagBadgeWidgetState();
}

class _TagBadgeWidgetState extends State<TagBadgeWidget> {
  @override
  Widget build(BuildContext context) {
  final theme = Provider.of<ThemeChanger>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom:2),
      child: Container(
        height: 20,
        margin: const EdgeInsets.only(right:5),
        //padding : const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
        color: widget.tag.color != 0 ? Color(widget.tag.color): theme.getTheme.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom:0),
          child: Text(widget.tag.label,style: const TextStyle(
            fontSize: 11,
            //color: theme.getTheme.dialogBackgroundColor
          )),
        )
      ),
    );
  }
}