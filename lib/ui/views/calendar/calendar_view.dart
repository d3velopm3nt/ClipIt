import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/views/calendar/calendar_day_widget.dart';
import 'package:flutter_my_clipboard/ui/widgets/clip/clip-collection_wiget.dart';
import 'package:provider/provider.dart';
import '../../../services/clip_manager_service.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  ClipManager manager = ClipManager();
  @override
  Widget build(BuildContext context) {
    manager = Provider.of<ClipManager>(context);
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          ClipCollection(
              title: 'Today',
              description: DateTime.now().toString(),
              clips: manager
                  .getByDate(DateTime.now())
                  //.map((clip) => ClipItemWidget(clip: clip))
                  .toList()),
          ClipCollection(
              title: 'Yesterday',
              description:
                  DateTime.now().subtract(const Duration(days: 1)).toString(),
              clips: manager
                  .getByDate(DateTime.now().subtract(const Duration(days: 1)))
                  //.map((clip) => ClipItemWidget(clip: clip))
                  .toList()),
          ...buildCalendarbuildMonths()
          // Expanded(
          //     child: Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: GridView.count(
          //       crossAxisCount: 4,
          //       mainAxisSpacing: 10,

          //       crossAxisSpacing: 10,
          //       children: [...buildCalendar()]),
          // ))
        ],
      ),
    ));
  }

  buildCalendar() {
    List<CalendarDayWidget> days = [];
    for (var i = 0; i < 31; i++) {
      days.add(CalendarDayWidget(day: i + 1));
    }
    return days;
  }

  List<Widget> buildCalendarbuildMonths() {
    var months = manager.clips
        .map((e) => DateTime.parse(e.datetime).month)
        .toSet()
        .toList();
    List<Widget> widgets = [];
    for (var i = 0; i < months.length; i++) {
      widgets.add(ClipCollection(
        clips: manager.getByMonth(months[i]),
        title: getMonthLabel(months[i]),
      ));
    }
    return widgets;
  }

  String getMonthLabel(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "No Month Exists";
    }
  }
}
