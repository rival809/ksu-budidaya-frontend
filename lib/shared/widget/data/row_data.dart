// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class RowData extends StatefulWidget {
  final String titleLeft;
  final String subtitleLeft;
  final String titleRight;
  final String subtitleRight;

  const RowData({
    Key? key,
    required this.titleLeft,
    required this.subtitleLeft,
    required this.titleRight,
    required this.subtitleRight,
  }) : super(key: key);

  @override
  State<RowData> createState() => _RowDataState();
}

class _RowDataState extends State<RowData> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.titleLeft,
                style: myTextTheme.bodyMedium?.copyWith(
                  color: gray600,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.subtitleLeft,
                style: myTextTheme.titleMedium?.copyWith(
                  color: gray800,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.titleRight,
                style: myTextTheme.bodyMedium?.copyWith(
                  color: gray600,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.subtitleRight,
                style: myTextTheme.titleMedium,
              )
            ],
          ),
        ),
      ],
    );
  }
}
