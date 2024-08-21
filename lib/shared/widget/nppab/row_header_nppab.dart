// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class RowHeaderNppab extends StatefulWidget {
  const RowHeaderNppab({
    Key? key,
  }) : super(key: key);

  @override
  State<RowHeaderNppab> createState() => _RowHeaderNppabState();
}

class _RowHeaderNppabState extends State<RowHeaderNppab> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Text(
              "DGN RINCIAN SBB",
              style: bodyXSmall.copyWith(
                color: gray900,
              ),
            ),
          ),
          const VerticalDivider(
            color: gray300,
            thickness: 1,
          ),
          Expanded(
            child: Text(
              "POKOK",
              style: bodyXSmall.copyWith(
                color: gray900,
                height: 1.5,
              ),
            ),
          ),
          const VerticalDivider(
            color: gray300,
            thickness: 1,
          ),
          Expanded(
            child: Text(
              "DENDA",
              style: bodyXSmall.copyWith(
                color: gray900,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
