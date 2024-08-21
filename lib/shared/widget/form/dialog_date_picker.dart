// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DialogDatePicker extends StatefulWidget {
  final String? initialDate;

  const DialogDatePicker({
    Key? key,
    required this.initialDate,
  }) : super(key: key);

  @override
  State<DialogDatePicker> createState() => DialogDatePickerState();
}

class DialogDatePickerState extends State<DialogDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        colorScheme: const ColorScheme.light(
          primary: yellow600,
        ),
      ),
      child: DatePickerDialog(
        firstDate: DateTime(1),
        lastDate: DateTime(4000),
        initialDate: DateTime.parse(
          checkDate(
            widget.initialDate ?? DateTime.now().toString(),
            // DateTime.now().toString(),
          ),
        ),
      ),
    );
  }
}
