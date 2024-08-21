// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

class ContainerBody extends StatefulWidget {
  final Widget child;
  final bool isAppbar;

  const ContainerBody({
    Key? key,
    required this.child,
    this.isAppbar = true,
  }) : super(key: key);

  @override
  State<ContainerBody> createState() => _ContainerBodyState();
}

class _ContainerBodyState extends State<ContainerBody> {
  @override
  Widget build(BuildContext context) {
    final appBarHeight = widget.isAppbar
        ? AppBar().preferredSize.height + MediaQuery.of(context).padding.top
        : 0.0;
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    appBarHeight -
                    kToolbarHeight -
                    10,
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
