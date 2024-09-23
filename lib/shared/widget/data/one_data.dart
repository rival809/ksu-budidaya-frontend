// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class OneData extends StatefulWidget {
  final String title;
  final String subtitle;

  const OneData({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  State<OneData> createState() => _OneDataState();
}

class _OneDataState extends State<OneData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Get.theme.textTheme.bodyMedium?.copyWith(color: gray600),
          ),
          const SizedBox(
            height: 4.0,
          ),
          Text(
            widget.subtitle,
            style: Get.theme.textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
