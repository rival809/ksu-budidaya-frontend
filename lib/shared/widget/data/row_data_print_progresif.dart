// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class RowDataPrintProgresif extends StatefulWidget {
  final String title;
  final String subtitle;

  const RowDataPrintProgresif({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  State<RowDataPrintProgresif> createState() => _RowDataPrintProgresifState();
}

class _RowDataPrintProgresifState extends State<RowDataPrintProgresif> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            widget.title,
            style: myTextTheme.bodyLarge?.copyWith(
              color: gray900,
              height: 1.5,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ":",
                style: myTextTheme.bodyLarge?.copyWith(
                  color: gray900,
                  height: 1.5,
                ),
              ),
              const SizedBox(
                width: 4.0,
              ),
              Expanded(
                child: Text(
                  widget.subtitle,
                  style: myTextTheme.bodyLarge?.copyWith(
                    color: gray900,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
