import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleDesc extends StatelessWidget {
  final String title;
  final String? description;
  final TextStyle? titleStyle;
  const TitleDesc({Key? key, required this.title,this.titleStyle, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,style: titleStyle),
      if (description != null)
        Text(description as String,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            )),
    ]);
  }
}
