// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class OneData extends StatefulWidget {
  final String title;
  final String subtitle;

  const OneData({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  State<OneData> createState() => _OneDataState();
}

class _OneDataState extends State<OneData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: myTextTheme.bodyMedium?.copyWith(color: gray600),
        ),
        const SizedBox(
          height: 4.0,
        ),
        Text(
          widget.subtitle,
          style: myTextTheme.titleMedium?.copyWith(color: gray800),
        )
      ],
    );
  }
}
