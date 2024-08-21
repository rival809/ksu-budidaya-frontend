import 'package:intl/intl.dart';

class DateLocalization {
  static String formatDate(DateTime dateTime, String locale) {
    final DateFormat formatter =
        DateFormat.yMMMMEEEEd(locale); // Define your format here
    return formatter.format(dateTime);
  }
}
