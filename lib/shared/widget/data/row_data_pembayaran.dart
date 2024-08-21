// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class RowDataPembayaran extends StatefulWidget {
  final String titleLeft;
  final String subtitleLeft;
  final String titleRight;
  final String subtitleRight;

  const RowDataPembayaran({
    Key? key,
    required this.titleLeft,
    required this.subtitleLeft,
    required this.titleRight,
    required this.subtitleRight,
  }) : super(key: key);

  @override
  State<RowDataPembayaran> createState() => _RowDataPembayaranState();
}

class _RowDataPembayaranState extends State<RowDataPembayaran> {
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
                  color: gray600,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.subtitleLeft,
                style: myTextTheme.titleLarge?.copyWith(
                  color: green600,
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
                  color: gray600,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.subtitleRight,
                style: myTextTheme.titleLarge?.copyWith(
                  color: green600,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
