import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

void handleDioException(DioException e, BuildContext context) {
  if (e.error.toString().contains("Connection failed")) {
    showInfoDialog("Tidak dapat terhubung ke server", context);
  } else {
    showInfoDialog(e.toString(), context);
  }
}
