import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class UbahKataSandiView extends StatefulWidget {
  const UbahKataSandiView({Key? key}) : super(key: key);

  Widget build(context, UbahKataSandiController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah kata sandi "),
        leading: IconButton(
          onPressed: () {
            router.go("/beranda");
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: ScreenTypeLayout.builder(
          mobile: (BuildContext context) =>
              ContentUbahKataSandi(controller: controller),
          desktop: (BuildContext context) => Center(
            child: Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width / 2,
              child: ContentUbahKataSandi(controller: controller),
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<UbahKataSandiView> createState() => UbahKataSandiController();
}
