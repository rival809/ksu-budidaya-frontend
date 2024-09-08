// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:ksu_budidaya/core.dart';

class BodyContainer extends StatefulWidget {
  final Widget contentBody;

  const BodyContainer({
    Key? key,
    required this.contentBody,
  }) : super(key: key);

  @override
  State<BodyContainer> createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context);

    return Scaffold(
      body: SliderDrawer(
        key: drawerProvider.sliderDrawerKey,
        appBar: SliderAppBar(
          appBarPadding: EdgeInsets.zero,
          appBarColor: neutralWhite,
          drawerIcon: InkWell(
            onTap: () {
              drawerProvider.toggleDrawer();
            },
            child: Row(
              children: [
                const SizedBox(
                  width: 24.0,
                ),
                SvgPicture.asset(
                  drawerProvider.isDrawerOpen ? iconMenuOpen : iconMenu,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Menu",
                    style: myTextTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          title: const Text(""),
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
        child: widget.contentBody,
      ),
    );
  }
}
