import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class CardLabel extends StatelessWidget {
  final Color cardBorderColor;
  final Color cardColor;
  final String cardTitle;
  final Color cardTitleColor;
  const CardLabel(
      {super.key,
      required this.cardColor,
      required this.cardTitle,
      required this.cardTitleColor,
      required this.cardBorderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            18.0,
          ),
        ),
        border: Border.all(color: cardBorderColor),
      ),
      child: SizedBox(
        width: 100,
        child: Text(
          cardTitle,
          textAlign: TextAlign.center,
          style: myTextTheme.labelSmall?.copyWith(
            color: cardTitleColor,
            letterSpacing: 0,
            height: 1.35,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
