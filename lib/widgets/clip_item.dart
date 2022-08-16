import 'package:flutter/material.dart';

class ClipItem extends StatelessWidget {
  final String copiedText;
  const ClipItem({Key? key, required this.copiedText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:  Card(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
          child:  SizedBox(
            child: Text(copiedText),
          )),
    );
  }
}
