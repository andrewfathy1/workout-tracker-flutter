import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String getCurrentWeekRange() {
    final startOfWeek = subtract(Duration(days: weekday - 1));
    final endOfWeek = add(Duration(days: DateTime.daysPerWeek - weekday));

    DateFormat dateFormat = DateFormat.MMMd();
    return '(${dateFormat.format(startOfWeek)} - ${dateFormat.format(endOfWeek)})';
  }
}
