// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ContainerLoadingRole extends StatefulWidget {
  const ContainerLoadingRole({
    Key? key,
  }) : super(key: key);

  @override
  State<ContainerLoadingRole> createState() => _ContainerLoadingRoleState();
}

class _ContainerLoadingRoleState extends State<ContainerLoadingRole> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => Container(
        padding: const EdgeInsets.all(24),
        constraints: BoxConstraints.loose(
          Size.fromHeight(MediaQuery.of(context).size.height -
              144 -
              AppBar().preferredSize.height),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: gray300,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      desktop: (context) => Container(
        padding: const EdgeInsets.all(24),
        constraints: BoxConstraints.loose(
          Size.fromHeight(MediaQuery.of(context).size.height -
              120 -
              AppBar().preferredSize.height -
              40),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: gray300,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
