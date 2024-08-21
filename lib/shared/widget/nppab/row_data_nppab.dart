// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class RowDataNppab extends StatefulWidget {
  final String title;
  final String subtitle;

  const RowDataNppab({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  State<RowDataNppab> createState() => _RowDataNppabState();
}

class _RowDataNppabState extends State<RowDataNppab> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            widget.title,
            style: bodyXSmall.copyWith(
              color: gray900,
              height: 1.5,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                ":",
                style: myTextTheme.bodySmall?.copyWith(
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
                  style: bodyXSmall.copyWith(
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
