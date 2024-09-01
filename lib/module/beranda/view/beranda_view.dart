import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({Key? key}) : super(key: key);

  Widget build(context, BerandaController controller) {
    controller.view = this;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(9),
                child: Image.asset(
                  "assets/images/logo/logo.png",
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: ScreenTypeLayout.builder(
          mobile: (BuildContext context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ContentBeranda(
              controller: controller,
            ),
          ),
          desktop: (BuildContext context) => Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: ContentBeranda(
                controller: controller,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<BerandaView> createState() => BerandaController();
}
