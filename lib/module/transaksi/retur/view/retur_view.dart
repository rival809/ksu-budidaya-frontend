import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ReturView extends StatefulWidget {
  const ReturView({Key? key}) : super(key: key);

  Widget build(context, ReturController controller) {
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
                  ? ContainerListRetur(controller: controller)
                  : ContainerRetur(controller: controller),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<ReturView> createState() => ReturController();
}
