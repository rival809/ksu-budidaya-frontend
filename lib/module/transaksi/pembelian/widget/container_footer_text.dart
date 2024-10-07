// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ContainerFooterText extends StatefulWidget {
  final String text;
  const ContainerFooterText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ContainerFooterText> createState() => _ContainerFooterTextState();
}

class _ContainerFooterTextState extends State<ContainerFooterText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 9.5,
      ),
      width: MediaQuery.of(globalContext).size.width,
      decoration: const BoxDecoration(
        color: gray100,
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: blueGray50,
          ),
        ),
      ),
      child: Text(
        widget.text,
        style: myTextTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
