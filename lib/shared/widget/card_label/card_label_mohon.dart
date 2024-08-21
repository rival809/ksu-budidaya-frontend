import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class CardLabelMohon extends StatelessWidget {
  final String cardTitle;
  const CardLabelMohon({
    super.key,
    required this.cardTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: blue50,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            18.0,
          ),
        ),
        border: Border.all(
          color: blue600,
        ),
      ),
      child: SizedBox(
        width: 100,
        child: Text(
          cardTitle,
          textAlign: TextAlign.center,
          style: myTextTheme.bodySmall?.copyWith(color: blue800),
        ),
      ),
    );
  }
}
