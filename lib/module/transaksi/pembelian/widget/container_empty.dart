// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ContainerEmpty extends StatefulWidget {
  const ContainerEmpty({
    Key? key,
  }) : super(key: key);

  @override
  State<ContainerEmpty> createState() => _ContainerEmptyState();
}

class _ContainerEmptyState extends State<ContainerEmpty> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
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
    );
  }
}
