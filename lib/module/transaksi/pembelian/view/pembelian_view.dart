import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class PembelianView extends StatefulWidget {
  const PembelianView({Key? key}) : super(key: key);

  Widget build(context, PembelianController controller) {
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
                  ? ContainerListPembelian(controller: controller)
                  : ContainerPembelian(controller: controller),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<PembelianView> createState() => PembelianController();
}
