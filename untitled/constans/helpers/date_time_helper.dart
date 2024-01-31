import 'package:intl/intl.dart';

formatDateFromString(String? dateStr) {
  var date = DateFormat.yMMMd().format(
    DateTime.parse(dateStr!).toLocal(),
  );
  var time = DateFormat("hh:mm a").format(
    DateTime.parse(dateStr).toLocal(),
  );
  String dateTimeStr = "$date $time";
  return dateTimeStr;
}

formatDateFromMiliseconds(String? time) {
  var datetime = DateTime.fromMillisecondsSinceEpoch(int.parse(time!));
  var localDate = DateFormat.yMMMd().format(
    datetime.toLocal(),
  );
  var localTime = DateFormat("hh:mm a").format(
    datetime.toLocal(),
  );
  String dateTimeStr = "$localDate $localTime";
  return dateTimeStr;
}
