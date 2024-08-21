// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class RowDataTiga extends StatefulWidget {
  final String titleLeft;
  final String subtitleLeft;
  final String titleMid;
  final String subtitleMid;
  final String titleRight;
  final String subtitleRight;

  const RowDataTiga({
    Key? key,
    required this.titleLeft,
    required this.subtitleLeft,
    required this.titleMid,
    required this.subtitleMid,
    required this.titleRight,
    required this.subtitleRight,
  }) : super(key: key);

  @override
  State<RowDataTiga> createState() => _RowDataTigaState();
}

class _RowDataTigaState extends State<RowDataTiga> {
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
                style: myTextTheme.bodyMedium?.copyWith(
                  color: gray600,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.subtitleLeft,
                style: myTextTheme.labelLarge?.copyWith(
                  color: gray800,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 4.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.titleMid,
                style: myTextTheme.bodyMedium?.copyWith(
                  color: gray600,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.subtitleMid,
                style: myTextTheme.labelLarge?.copyWith(
                  color: gray800,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 4.0,
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
                style: myTextTheme.labelLarge?.copyWith(
                  color: gray800,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
