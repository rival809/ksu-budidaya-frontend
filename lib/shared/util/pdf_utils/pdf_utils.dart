import 'package:ksu_budidaya/core.dart';

String generateDashLine(String? string1, String? string2) {
  int maxString = findMaxString(string1, string2);
  String dashLine = "";
  for (var i = 0; i < maxString; i++) {
    dashLine += "-";
  }
  return dashLine;
}

int findMaxString(String? string1, String? string2) {
  if (string1!.length > string2!.length) {
    return string1.length;
  } else {
    return string2.length;
  }
}

String hourNow() {
  var now = DateTime.now();
  return DateFormat('HH:mm').format(now);
}

String dateNow() {
  var now = DateTime.now();
  return DateFormat('dd-MM-yyyy').format(now);
}
