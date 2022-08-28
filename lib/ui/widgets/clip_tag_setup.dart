import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/services/clip_tag_service.dart';
import 'package:flutter_my_clipboard/ui/widgets/shared/color_selector.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../app/app-notification.dart';
import '../../models/cliptag.model.dart';
import '../../services/datetime_service.dart';
import '../../theme/theme_changer.dart';
import 'shared/title_desc_widget.dart';

class ClipTagSetup extends StatefulWidget {
  final Function(bool closed) onClosed;
  ClipTag tag;
  ClipTagSetup({Key? key, required this.onClosed, required this.tag})
      : super(key: key);
  @override
  State<ClipTagSetup> createState() => _ClipTagSetupState();
}

class _ClipTagSetupState extends State<ClipTagSetup> {
  String configType = "Add";
  final labelControl = TextEditingController();
  ClipTagService tagService = ClipTagService();

  final colorControl = TextEditingController();

  bool isValid = false;
  bool saved = false;
  int saveAnimationDuration = 350;

  @override
  void initState() {
    if (widget.tag.label != "") {
      labelControl.text = widget.tag.label;
      configType = "Edit";
      isValid = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    tagService = Provider.of<ClipTagService>(context);

    return Card(
        child: Center(
            child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.local_offer_outlined),
                  TitleDesc(
                    title: "$configType Tag",
                    titleStyle: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  splashRadius: 20,
                  onPressed: () => {widget.onClosed(false)},
                  icon: const Icon(Icons.close))),
        ],
      ),
      //Tag List
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: ((text) {
            setState(() {
              isValid = text != "" ? true : false;
            });
          }),
          controller: labelControl,
          decoration: const InputDecoration(
              labelText: "Tag Label",
              prefixIcon: Icon(Icons.label),
              border: OutlineInputBorder(
                  //Outline border type for TextFeild
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 104, 99, 99),
                    width: 3,
                  ))),
        ),
      ),
      Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 30, top: 10, bottom: 10),
        child: Row(children: [
          Expanded(
              child: Row(children: const [
            Icon(Icons.format_paint),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Select Tag Color'),
            ),
          ])),
          ColorSelector(
              onColorChanged: (Color color) {
                widget.tag.color = color.value;
              },
              color: widget.tag.color != 0
                  ? Color(widget.tag.color)
                  : theme.getTheme.primaryColor)
        ]),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, top: 5, bottom: 15),
        child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedAlign(
              alignment: saved ? Alignment.centerRight : Alignment.centerLeft,
              duration: Duration(milliseconds: saveAnimationDuration),
              child: ElevatedButton(
                  onPressed: () async {
                    labelControl.text != ""
                        ? {
                            setState(() {
                              saveTag();
                              saved = true;
                            }),
                            await Future.delayed(
                                Duration(milliseconds: saveAnimationDuration)),
                            widget.onClosed(false)
                          }
                        : null;
                  },
                  style: ButtonStyle(
                      foregroundColor: isValid
                          ? MaterialStateProperty.all(Colors.black)
                          : MaterialStateProperty.all(Colors.grey),
                      backgroundColor: isValid
                          ? MaterialStateProperty.all(
                              theme.getTheme.secondaryHeaderColor)
                          : MaterialStateProperty.all(
                              const Color.fromARGB(255, 233, 227, 227))),
                  child: const Text("Save")),
            )),
      )
    ])));
  }

  saveTag() async {
    var message = "";
    if (configType == "Add") {
      widget.tag.label = labelControl.text;
      widget.tag.datetime = DateTimeService.currentDate;
      widget.tag.id = const Uuid().v1();
      message = "New tag created successfully";
    } else {
      widget.tag.label = labelControl.text;
      message = "Existing tag updated successefully";
    }
    await tagService.saveTag(widget.tag);

    AppNotification.saveNotification("Tag details saved", message);
  }
}
