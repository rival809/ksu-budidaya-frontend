import 'package:intl/date_symbol_data_local.dart';
import 'package:ksu_budidaya/core.dart';

formatDateDayMonthYear(String? date) {
  if (date == null || date.isEmpty) {
    return "-";
  } else if (date.contains("null")) {
    return "-";
  }
  initializeDateFormatting('id');

  DateTime dateConverted = DateTime.parse(date);
  return "${dateConverted.day.toString().padLeft(2, '0')}-${dateConverted.month.toString().padLeft(2, '0')}-${dateConverted.year.toString().padLeft(2, '0')}";
}

formatDate(String? date) {
  if (date!.isEmpty) {
    return "";
  } else if (date.contains("null")) {
    return "";
  }
  initializeDateFormatting('id');

  DateTime dateConverted = DateTime.parse(date);
  return "${dateConverted.day.toString().padLeft(2, '0')}-${dateConverted.month.toString().padLeft(2, '0')}-${dateConverted.year.toString().padLeft(2, '0')}";
}

String convertDateString(String originalDateString) {
  try {
    DateFormat originalFormat = DateFormat("dd-MM-yyyy, HH:mm");
    DateFormat desiredFormat = DateFormat("yyyy-MM-dd, HH:mm");

    DateTime dateTime = originalFormat.parse(originalDateString);

    String formattedDateString = desiredFormat.format(dateTime);

    return formattedDateString;
  } catch (e) {
    print("Error parsing date: $e");
    return "";
  }
}

String formatDateToYearMonthDay(String originalDateString) {
  try {
    DateFormat originalFormat = DateFormat("dd-MM-yyyy, HH:mm");
    DateFormat desiredFormat = DateFormat("yyyy-MM-dd");

    DateTime dateTime = originalFormat.parse(originalDateString);

    String formattedDateString = desiredFormat.format(dateTime);

    return formattedDateString;
  } catch (e) {
    print("Error parsing date: $e");
    return "";
  }
}

formatDateTime(String? dateTime) {
  if (dateTime?.isEmpty ?? true) {
    return "-";
  } else if (dateTime.toString().contains("null")) {
    return "-";
  }
  initializeDateFormatting('id');
  DateTime date = DateTime.parse(dateTime ?? "");

  return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
}

formatDateTimePayload(String? dateTime) {
  if (dateTime?.isEmpty ?? true) {
    return "-";
  } else if (dateTime.toString().contains("null")) {
    return "-";
  }
  initializeDateFormatting('id');
  DateTime now = DateTime.now();
  DateTime date = DateTime.parse(dateTime ?? "");

  return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
}

formatSelectedDate(DateTime selectedDate) {
  String selectedDateString = DateFormat('yyyy-MM-dd').format(selectedDate);
  return selectedDateString;
}

formatSelectedTime(DateTime selectedDate) {
  String selectedDateString = DateFormat('HH:mm:ss').format(selectedDate);
  return selectedDateString;
}

String formatSelectedDateFull(DateTime selectedDate) {
  String selectedDateString =
      DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDate);
  return selectedDateString;
}

formatDateFull(String? date) {
  if (date.toString().isEmpty) {
    return "-";
  } else if (date.toString().contains("null")) {
    return "-";
  }
  initializeDateFormatting('id');

  DateTime dateConverted = DateTime.parse(date.toString());
  String formattedDate = DateFormat.yMMMMd('id').format(dateConverted);

  return formattedDate.toUpperCase();
}

formatDateWithTime(String? date) {
  if (date.toString().isEmpty) {
    return "-";
  } else if (date.toString().contains("null")) {
    return "-";
  }
  initializeDateFormatting('id');

  DateTime originalDate = DateTime.parse(date.toString());

  String formattedDate = DateFormat('d MMMM y HH:mm:ss').format(originalDate);

  return formattedDate.toUpperCase();
}

formatOnlyDate(String? date) {
  if (date.toString().isEmpty) {
    return "-";
  } else if (date.toString().contains("null")) {
    return "-";
  }
  initializeDateFormatting('id');

  DateTime originalDate = DateTime.parse(date.toString());

  String formattedDate = DateFormat('yyyy-MM-dd').format(originalDate);

  return formattedDate;
}

ubahFormatTanggal(String tanggal) {
  DateTime dateTime = DateTime.parse(tanggal);

  String tanggalAkhir =
      "${dateTime.day.toString().padLeft(2, '0')}${dateTime.month.toString().padLeft(2, '0')}${dateTime.year.toString()}";

  return tanggalAkhir;
}

getTimeFromDate(String date) {
  DateTime timestamp = DateTime.parse(date);
  String time = DateFormat('HH:mm:ss').format(timestamp);
  return time;
}

cekFormatDate(String? date) {
  if (trimString(date).isEmpty) {
    return null;
  } else if (date.toString().contains("null")) {
    return null;
  } else {
    try {
      DateTime originalDate = DateTime.parse(date.toString());
      String formattedDate = DateFormat('yyyy-MM-dd').format(originalDate);
      return formattedDate;
    } catch (e) {
      return null;
    }
  }
}
