// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/shared/theme/theme_config.dart';

class BasePrefixRupiah extends StatefulWidget {
  const BasePrefixRupiah({
    super.key,
  });

  @override
  State<BasePrefixRupiah> createState() => _BasePrefixRupiahState();
}

class _BasePrefixRupiahState extends State<BasePrefixRupiah> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 12),
      child: Container(
        width: 40,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(6),
            topLeft: Radius.circular(6),
          ),
          color: gray100,
        ),
        child: Center(
          child: Text(
            "Rp",
            style: myTextTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
