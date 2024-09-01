import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:ksu_budidaya/module/beranda/widget/slider_view.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({Key? key}) : super(key: key);

  Widget build(context, BerandaController controller) {
    controller.view = this;
    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
          appBarPadding: EdgeInsets.zero,
          appBarColor: neutralWhite,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Menu",
              style: myTextTheme.titleMedium,
            ),
          ),
          trailing: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      "Irwan Ramadhan",
                      style: myTextTheme.titleSmall,
                    ),
                    Text(
                      "Admin",
                      style: bodyXSmall,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 8.0,
                ),
                SvgPicture.asset(
                  iconChevronDown,
                ),
                const SizedBox(
                  width: 24.0,
                ),
              ],
            ),
          ),
        ),
        slider: SliderView(
          onItemClick: (title) {
            print(title);
          },
        ),
        child: Container(
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
      ),
    );
  }

  @override
  State<BerandaView> createState() => BerandaController();
}
