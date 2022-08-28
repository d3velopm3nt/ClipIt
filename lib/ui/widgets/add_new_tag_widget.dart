import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_changer.dart';
import 'shared/title_desc_widget.dart';

class AddNewTagWidget extends StatelessWidget {
  final Function() onPressed;
  const AddNewTagWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Card(
      child: InkWell(
        onTap: () {
          onPressed();
        },
        borderRadius: BorderRadius.circular(10),
        hoverColor: theme.getTheme.secondaryHeaderColor,
        mouseCursor: MaterialStateMouseCursor.clickable,
        child: Center(
          child: Row(children: [
            const Expanded(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TitleDesc(
                  title: 'Add Tag',
                  titleStyle: TextStyle(fontSize: 15),
                  description: 'Create new tag label'),
            )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.getTheme.secondaryHeaderColor),
                  child: const Icon(Icons.add),
                ))
          ]),
        ),
      ),
    );
  }
}
