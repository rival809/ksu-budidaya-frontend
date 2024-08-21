import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DrawerMenu extends StatelessWidget {
  final String title, pathIcon;
  final Function() onTap;
  final bool isChildren;

  const DrawerMenu({
    super.key,
    required this.title,
    required this.pathIcon,
    required this.onTap,
    required this.isChildren,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      minLeadingWidth: 0,
      leading: isChildren ? null : SvgPicture.asset(pathIcon),
      title: Text(
        title,
        style: myTextTheme.labelLarge,
      ),
      onTap: onTap,
    );
  }
}
