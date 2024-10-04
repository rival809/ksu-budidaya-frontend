// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class FooterPenjualan extends StatefulWidget {
  const FooterPenjualan({
    Key? key,
  }) : super(key: key);

  @override
  State<FooterPenjualan> createState() => _FooterPenjualanState();
}

class _FooterPenjualanState extends State<FooterPenjualan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: blueGray50,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: gray100,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Aksi ",
                  style: myTextTheme.displayLarge?.copyWith(
                    color: gray100,
                    fontWeight: FontWeight.w600,
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
                  color: gray100,
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "ID Produk",
                  style: myTextTheme.displayLarge?.copyWith(
                    color: gray100,
                    fontWeight: FontWeight.w600,
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
                  color: gray100,
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Nama Produk",
                  style: myTextTheme.displayLarge?.copyWith(
                    color: gray100,
                    fontWeight: FontWeight.w600,
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
                  color: gray100,
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Total",
                  style: myTextTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w600,
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
                  color: gray100,
                ),
                padding: const EdgeInsets.all(8),
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
                  color: gray100,
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Rp",
                  style: myTextTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w600,
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
                  color: gray100,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "20.000",
                  style: myTextTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w600,
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
