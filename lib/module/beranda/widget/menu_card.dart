import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final Function() onTap;

  const MenuCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: gray300,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: myTextTheme.titleMedium,
              ),
              SvgPicture.asset(
                iconChevronKanan,
                colorFilter: colorFilterGray900,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
