// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class RowDataEmpat extends StatefulWidget {
  final String titleLeft;
  final String subtitleLeft;
  final String titleLeftMid;
  final String subtitleLeftMid;
  final String titleRightMid;
  final String subtitleRightMid;
  final String titleRight;
  final String subtitleRight;

  const RowDataEmpat({
    Key? key,
    required this.titleLeft,
    required this.subtitleLeft,
    required this.titleLeftMid,
    required this.subtitleLeftMid,
    required this.titleRightMid,
    required this.subtitleRightMid,
    required this.titleRight,
    required this.subtitleRight,
  }) : super(key: key);

  @override
  State<RowDataEmpat> createState() => _RowDataEmpatState();
}

class _RowDataEmpatState extends State<RowDataEmpat> {
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
                widget.titleLeftMid,
                style: myTextTheme.bodyMedium?.copyWith(
                  color: gray600,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.subtitleLeftMid,
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
                widget.titleRightMid,
                style: myTextTheme.bodyMedium?.copyWith(
                  color: gray600,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                widget.subtitleRightMid,
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
                style: myTextTheme.titleMedium?.copyWith(
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
