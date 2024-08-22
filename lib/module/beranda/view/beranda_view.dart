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
                child: SvgPicture.asset(
                  "assets/images/logo/logo_siberat.svg",
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 16,
        ),
        child: PrimaryButton(
          pathIcon: "assets/icons/misc/open_in_new.svg",
          text: "SIPANDU JAWARA",
          onPressed: () {
            controller.launchInBrowser();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      drawer: const DrawerBeranda(
        isBeranda: true,
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
