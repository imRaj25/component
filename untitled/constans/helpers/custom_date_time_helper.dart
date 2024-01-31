import 'package:intl/intl.dart';

class CustomDateTimeHelper {
  static String dateFromMiliseconds(int timestamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('dd-MM-yyyy').format(dt);
  }

  static String dateMonthYearFromMiliseconds(int timestamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('dd MMM, yyyy').format(dt);
  }
}
