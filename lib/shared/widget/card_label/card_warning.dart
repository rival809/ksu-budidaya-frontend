// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class CardWarning extends StatefulWidget {
  final Color cardColor;
  final Color borderColor;
  final String text;
  final String pathIcon;
  const CardWarning({
    Key? key,
    required this.cardColor,
    required this.borderColor,
    required this.text,
    required this.pathIcon,
  }) : super(key: key);

  @override
  State<CardWarning> createState() => _CardWarningState();
}

class _CardWarningState extends State<CardWarning> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.cardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: widget.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              widget.pathIcon,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Text(
                widget.text,
                style: myTextTheme.bodyMedium?.copyWith(color: gray800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
