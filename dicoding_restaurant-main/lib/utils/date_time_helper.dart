import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {
    // Date and Time format
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecific = "11:00:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    // Today Format
    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    // Tommorow Format
    var formatted = resultToday.add(const Duration(days: 1));
    final tommorowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tommorowDate $timeSpecific";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
