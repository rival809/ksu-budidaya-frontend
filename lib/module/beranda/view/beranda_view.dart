import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({Key? key}) : super(key: key);

  Widget build(context, BerandaController controller) {
    controller.view = this;
    return BodyContainer(
      contentBody: Container(
        color: appLightBackground,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: ScreenTypeLayout.builder(
            mobile: (BuildContext context) => ContentBeranda(
              controller: controller,
            ),
            desktop: (BuildContext context) => ContentBeranda(
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<BerandaView> createState() => BerandaController();
}
