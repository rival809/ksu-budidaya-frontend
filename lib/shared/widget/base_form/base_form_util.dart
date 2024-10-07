import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

Future<DateTime?> initSelectedDate({required String? initValue}) async {
  DateTime? selectedDate = await showDatePicker(
    context: globalContext,
    initialDate: DateTime.parse(
      checkDate(trimString(initValue).toString().isEmpty
          ? DateTime.now().toString()
          : formatDateToYearMonthDay(trimString(initValue))),
    ),
    firstDate: DateTime(1900),
    lastDate: DateTime(DateTime.now().year + 1),
    locale: const Locale('id', 'ID'),
  );
  return selectedDate;
}
