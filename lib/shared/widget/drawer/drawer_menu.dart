import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DrawerMenu extends StatefulWidget {
  final String title;
  final String? pathIcon;
  final Function() onTap;
  final bool? isSubMenu;
  final bool? isSelected;
  final List<Widget>? children;
  final bool isInitiallyExpanded;

  const DrawerMenu({
    super.key,
    required this.title,
    this.pathIcon,
    required this.onTap,
    this.isSubMenu,
    this.isSelected,
    this.children,
    this.isInitiallyExpanded = false,
  });

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isInitiallyExpanded;
    if (widget.isSelected == true) {
      isExpanded = !isExpanded;
    }
  }

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            color: widget.isSelected ?? false
                ? widget.isSubMenu ?? false
                    ? green100
                    : primaryColor
                : neutralWhite,
          ),
          child: ListTile(
            hoverColor: primaryGreen,
            tileColor: widget.isSelected ?? false
                ? primaryColor
                : widget.isSubMenu ?? false
                    ? green100
                    : neutralWhite,
            contentPadding: const EdgeInsets.all(0),
            trailing: widget.pathIcon != null
                ? SvgPicture.asset(trimString(widget.pathIcon!))
                : (widget.children != null
                    ? SvgPicture.asset(
                        isExpanded ? iconChevronUp : iconChevronDown,
                        colorFilter: widget.isSelected ?? false
                            ? colorFilter(color: neutralWhite)
                            : null,
                      )
                    : null),
            minLeadingWidth: 0,
            leading: widget.isSubMenu ?? false
                ? SvgPicture.asset(
                    iconDot,
                    colorFilter:
                        widget.isSelected ?? false ? colorFilterPrimary : null,
                  )
                : null,
            title: Text(
              widget.title,
              style: myTextTheme.titleMedium?.copyWith(
                  color: widget.isSelected ?? false
                      ? widget.isSubMenu ?? false
                          ? primaryColor
                          : neutralWhite
                      : gray900),
            ),
            onTap: () {
              if (widget.children != null) {
                toggleExpansion();
              } else {
                widget.onTap();
              }
            },
          ),
        ),
        if (isExpanded && widget.children != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.children!,
          ),
      ],
    );
  }
}
