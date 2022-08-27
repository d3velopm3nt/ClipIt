import 'package:flutter_my_clipboard/services/datetime_service.dart';
import 'package:test/test.dart';

void main() {
  group('Date Time Service', () {
    test('get current date time in correct format', () {
      var currentDate = DateTime.now().toString();
      currentDate = currentDate.substring(0, currentDate.lastIndexOf('.'));
      expect(DateTimeService.currentDate, currentDate);
    });

    // test('Get current date with date only format', () {
    //   var currentDate = DateTime.now().toString();
    //   var date = DateTimeService.getDate(currentDate);

    //   expect(date, DateTime.parse(currentDate).);
    // });
  });
}
