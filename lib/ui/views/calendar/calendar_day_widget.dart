import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme_changer.dart';

class CalendarDayWidget extends StatefulWidget {
  final int day;
  const CalendarDayWidget({Key? key, required this.day}) : super(key: key);

  @override
  State<CalendarDayWidget> createState() => _CalendarDayWidgetState();
}

class _CalendarDayWidgetState extends State<CalendarDayWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Container(
      height: 30,
      width: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.getTheme.primaryColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(
                  color: theme.getTheme.secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(widget.day.toString(),
                  style: const TextStyle(fontSize: 15, color: Colors.black))),
          const Text("0", style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
