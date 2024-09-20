// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:ksu_budidaya/core.dart';

class BodyContainer extends StatefulWidget {
  final Widget contentBody;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionLocation;

  const BodyContainer({
    Key? key,
    required this.contentBody,
    this.floatingActionButton,
    this.floatingActionLocation,
  }) : super(key: key);

  @override
  State<BodyContainer> createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  final GlobalKey<SliderDrawerState> sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (drawerProvider.isDrawerOpen) {
        sliderDrawerKey.currentState!.openSlider();
      }
    });

    return Scaffold(
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionLocation,
      body: SliderDrawer(
        animationDuration: 200,
        key: sliderDrawerKey,
        appBar: SliderAppBar(
          appBarPadding: EdgeInsets.zero,
          appBarColor: neutralWhite,
          drawerIcon: InkWell(
            onTap: () {
              sliderDrawerKey.currentState!.isDrawerOpen
                  ? drawerProvider.toggleDrawer(false)
                  : drawerProvider.toggleDrawer(true);

              sliderDrawerKey.currentState!.openOrClose();
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
                      trimString(
                          UserDatabase.userDatabase.data?.userData?.name),
                      style: myTextTheme.titleSmall,
                    ),
                    Text(
                      trimString(
                          UserDatabase.userDatabase.data?.roleData?.roleName),
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
        slider: const SliderView(),
        child: widget.contentBody,
      ),
    );
  }
}
