import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/widgets/shared/title_desc_widget.dart';
import 'package:provider/provider.dart';

import '../../../models/cliptag.model.dart';
import '../../../theme/theme_changer.dart';

class TagSelectWidget extends StatefulWidget {
  TagSelectWidget({Key? key, required this.tag, required this.onSelected, required this.selected})
      : super(key: key);
  final ClipTag tag;
  bool selected ;
  final Function(bool) onSelected;
  @override
  State<TagSelectWidget> createState() => _TagSelectWidgetState();
}

class _TagSelectWidgetState extends State<TagSelectWidget> {
  late ThemeChanger theme;

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeChanger>(context);
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        hoverColor: theme.getTheme.primaryColor,
        mouseCursor: MaterialStateMouseCursor.clickable,
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.local_offer_outlined),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: TitleDesc(
                        title: widget.tag.label,
                        titleStyle: const TextStyle(fontSize: 15),
                        description: ''),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.scale(
                      scale: 1.0,
                      child: Checkbox(
                          value: widget.selected,
                          fillColor: MaterialStateProperty.all(
                              theme.getTheme.hintColor),
                          onChanged: (value) {
                            setState(() {
                              widget.selected = value!;
                              widget.onSelected(widget.selected);
                            });
                          }),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
