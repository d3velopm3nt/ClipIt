import 'package:flutter/material.dart';

import 'title_desc_widget.dart';

class AddNewTagWidget extends StatelessWidget {
  const AddNewTagWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
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
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 199, 235, 233))
                    ,child: const Icon(Icons.add),
                    
              ))
              ]),
            ),
      ),
    );
  }
}
