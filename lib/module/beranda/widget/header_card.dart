import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class HeaderCard extends StatelessWidget {
  final String pathIcon, title;

  const HeaderCard({
    super.key,
    required this.pathIcon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          pathIcon,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          title,
          style: myTextTheme.titleMedium,
        ),
      ],
    );
  }
}
