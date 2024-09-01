import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

Future<DateTime?> initSelectedDate(
    {required BuildContext context, required String? initValue}) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.parse(
      checkDate(trimString(initValue).toString().isEmpty
          ? DateTime.now().toString()
          : trimString(initValue)),
    ),
    firstDate: DateTime(1900),
    lastDate: DateTime(DateTime.now().year + 1),
    locale: const Locale('id', 'ID'),
  );
  return selectedDate;
}
