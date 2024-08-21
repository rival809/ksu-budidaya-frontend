// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class RowDataPrintInfoPkb extends StatefulWidget {
  final String titleLeft;
  final String subtitleLeft;
  final String titleRight;
  final String subtitleRight;

  const RowDataPrintInfoPkb({
    Key? key,
    required this.titleLeft,
    required this.subtitleLeft,
    required this.titleRight,
    required this.subtitleRight,
  }) : super(key: key);

  @override
  State<RowDataPrintInfoPkb> createState() => _RowDataPrintInfoPkbState();
}

class _RowDataPrintInfoPkbState extends State<RowDataPrintInfoPkb> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.titleLeft,
                style: myTextTheme.bodyLarge?.copyWith(
                  color: gray900,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.subtitleLeft,
                style: myTextTheme.bodyLarge?.copyWith(
                  color: gray900,
                  height: 1.5,
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
                style: myTextTheme.bodyLarge?.copyWith(
                  color: gray900,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.subtitleRight,
                style: myTextTheme.bodyLarge?.copyWith(
                  color: gray900,
                  height: 1.5,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
