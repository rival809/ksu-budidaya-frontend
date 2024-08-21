import 'package:ksu_budidaya/core.dart';

String mergerNoAlatBerat(String? noAb1, String? noAb2, String? noAb3) {
  if (trimString(noAb1).isEmpty &&
      trimString(noAb2).isEmpty &&
      trimString(noAb3).isEmpty) {
    return "-";
  }
  return "${trimString(noAb1)}-${trimString(noAb2)}-${trimString(noAb3)}";
}
