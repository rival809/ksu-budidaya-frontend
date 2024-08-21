// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/shared/theme/theme_config.dart';

class CardExpansionTile extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;

  const CardExpansionTile({
    Key? key,
    required this.title,
    required this.children,
    this.initiallyExpanded = true,
  }) : super(key: key);

  @override
  State<CardExpansionTile> createState() => _CardExpansionTileState();
}

class _CardExpansionTileState extends State<CardExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: ListTileTheme(
          horizontalTitleGap: 0,
          child: ExpansionTile(
            initiallyExpanded: widget.initiallyExpanded,
            iconColor: primaryGreen,
            collapsedIconColor: primaryGreen,
            title: Text(
              widget.title,
              style: myTextTheme.titleMedium,
            ),
            children: widget.children,
          ),
        ),
      ),
    );
  }
}
