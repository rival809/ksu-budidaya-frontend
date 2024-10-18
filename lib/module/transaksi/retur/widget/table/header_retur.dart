// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/shared/theme/theme_config.dart';

class HeaderRetur extends StatefulWidget {
  const HeaderRetur({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderRetur> createState() => _HeaderReturState();
}

class _HeaderReturState extends State<HeaderRetur> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 50,
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "ID Pembelian",
                  style: myTextTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: neutralWhite,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "ID Produk",
                  style: myTextTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: neutralWhite,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Divisi",
                  style: myTextTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: neutralWhite,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Nama Produk",
                  style: myTextTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: neutralWhite,
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Container(
              width: 110,
              padding: const EdgeInsets.all(8),
              child: Text(
                "Harga Beli",
                style: myTextTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: neutralWhite,
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Container(
              width: 60,
              padding: const EdgeInsets.all(8),
              child: Text(
                "Qty",
                textAlign: TextAlign.center,
                style: myTextTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: neutralWhite,
                ),
              ),
            ),
            Container(
              width: 1,
              color: blueGray50,
            ),
            Container(
              width: 150,
              padding: const EdgeInsets.all(8),
              child: Text(
                "Total Nilai Beli",
                style: myTextTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: neutralWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
