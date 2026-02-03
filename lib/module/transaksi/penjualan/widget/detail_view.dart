// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DetailView extends StatefulWidget {
  final PenjualanController controller;

  const DetailView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    PenjualanController controller = widget.controller;
    return BodyContainer(
      contentBody: Container(
        color: appLightBackground,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            color: neutralWhite,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ContainerDetailPenjualan(controller: controller),
            ),
          ),
        ),
      ),
    );
  }
}
