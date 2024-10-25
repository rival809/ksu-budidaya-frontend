// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class HeaderPenjualanDetail extends StatefulWidget {
  const HeaderPenjualanDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderPenjualanDetail> createState() => _HeaderPenjualanDetailState();
}

class _HeaderPenjualanDetailState extends State<HeaderPenjualanDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: blueGray50,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                  ),
                  color: primaryColor,
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "ID Produk",
                  style: myTextTheme.titleSmall?.copyWith(
                    color: neutralWhite,
                    height: 1.7,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Expanded(
              flex: 14,
              child: Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Nama Produk",
                  style: myTextTheme.titleSmall?.copyWith(
                    color: neutralWhite,
                    height: 1.7,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Harga",
                  style: myTextTheme.titleSmall?.copyWith(
                    color: neutralWhite,
                    height: 1.7,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Qty",
                  style: myTextTheme.titleSmall?.copyWith(
                    color: neutralWhite,
                    height: 1.7,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Disc. (%)",
                  style: myTextTheme.titleSmall?.copyWith(
                    color: neutralWhite,
                    height: 1.7,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Expanded(
              flex: 6,
              child: Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Total",
                  style: myTextTheme.titleSmall?.copyWith(
                    color: neutralWhite,
                    height: 1.7,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
