import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DropdownAksi extends StatefulWidget {
  final String? text;
  final Function(int)? onChange;
  final List<PopupMenuEntry<int>>? listItem;
  const DropdownAksi({
    super.key,
    required this.text,
    required this.onChange,
    this.listItem,
  });

  @override
  _DropdownAksiState createState() => _DropdownAksiState();
}

class _DropdownAksiState extends State<DropdownAksi> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      position: PopupMenuPosition.under,
      onSelected: widget.onChange,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                trimString(widget.text),
                textAlign: TextAlign.center,
                style: myTextTheme.labelLarge?.copyWith(
                  color: primaryColor,
                ),
              ),
            ),
            SvgPicture.asset(
              iconChevronDown,
              colorFilter: colorFilter(
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) => widget.listItem != null
          ? widget.listItem ?? []
          : [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    SvgPicture.asset(iconMiscInfo),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Detail Data',
                        style: myTextTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      iconDelete,
                      colorFilter: colorFilter(color: red600),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Hapus',
                      style: myTextTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
    );
  }
}
