// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class RowRincianMobile extends StatefulWidget {
  final String title;
  final String jumlah;
  final bool? status;

  const RowRincianMobile({
    Key? key,
    required this.title,
    required this.jumlah,
    this.status = true,
  }) : super(key: key);

  @override
  State<RowRincianMobile> createState() => _RowRincianStateMobile();
}

class _RowRincianStateMobile extends State<RowRincianMobile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Text(
            widget.title,
            style: myTextTheme.bodyMedium?.copyWith(
              color: gray700,
              height: 1.5,
            ),
          ),
        ),
        Text(
          "Rp.",
          style: myTextTheme.bodyMedium?.copyWith(
            color: gray500,
            height: 1.5,
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            widget.jumlah,
            textAlign: TextAlign.end,
            style: myTextTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: gray900,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
