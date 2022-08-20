class DateTimeService {
  static String get currentDate {
    var now = DateTime.now().toString();
    String convertedDateTime = "${getDate(now)} ${getTime(now)}";
    return convertedDateTime;
  }

  static String getTime(String datetime) {
    DateTime dt = DateTime.parse(datetime);

    return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}";
  }

  static String getDate(String datetime) {
    DateTime dt = DateTime.parse(datetime);
    return "${dt.year.toString()}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}";
  }
}
