import 'package:flutter/material.dart';

class ClipSearch extends StatelessWidget {
  final searchController = TextEditingController();
  final Function(String) onChanged;
  ClipSearch({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: searchController,
          onChanged: ((text) {
            onChanged(text);
          }),
          decoration: const InputDecoration(
              labelText: "Search for clips...",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  //Outline border type for TextFeild
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 104, 99, 99),
                    width: 3,
                  ))),
        ),
      ),
    );
  }
}
