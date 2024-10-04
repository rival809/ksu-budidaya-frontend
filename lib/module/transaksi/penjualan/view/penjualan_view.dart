import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class PenjualanView extends StatefulWidget {
  const PenjualanView({Key? key}) : super(key: key);

  Widget build(context, PenjualanController controller) {
    controller.view = this;

    return BodyContainer(
      contentBody: Container(
        color: appLightBackground,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            color: neutralWhite,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: controller.isList
                  ? ContainerListPenjualan(controller: controller)
                  : Container(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<PenjualanView> createState() => PenjualanController();
}
