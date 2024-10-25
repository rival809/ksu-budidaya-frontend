// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class HeaderCetakLabel extends StatefulWidget {
  const HeaderCetakLabel({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderCetakLabel> createState() => _HeaderCetakLabelState();
}

class _HeaderCetakLabelState extends State<HeaderCetakLabel> {
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
              flex: 5,
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
              flex: 7,
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
              flex: 3,
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
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Aksi",
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
