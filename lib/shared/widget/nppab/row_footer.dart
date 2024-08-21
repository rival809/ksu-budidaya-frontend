// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class RowFooter extends StatefulWidget {
  final String title;
  final String subtitle;

  const RowFooter({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  State<RowFooter> createState() => _RowFooterState();
}

class _RowFooterState extends State<RowFooter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            widget.title,
            style: myTextTheme.bodyMedium?.copyWith(
              color: gray900,
              height: 1.5,
            ),
          ),
        ),
        Text(
          ":",
          style: myTextTheme.bodySmall,
        ),
        const SizedBox(
          width: 4.0,
        ),
        Expanded(
          flex: 2,
          child: Text(
            widget.subtitle,
            style: myTextTheme.bodyMedium?.copyWith(
              color: gray900,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
