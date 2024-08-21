// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class LineDash extends StatefulWidget {
  const LineDash({
    Key? key,
  }) : super(key: key);

  @override
  State<LineDash> createState() => _LineDashState();
}

class _LineDashState extends State<LineDash> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        150 ~/ 3,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : gray900,
            height: 1,
          ),
        ),
      ),
    );
  }
}
