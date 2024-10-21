// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class FooterRetur extends StatefulWidget {
  final ReturController controller;

  const FooterRetur({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<FooterRetur> createState() => _FooterReturState();
}

class _FooterReturState extends State<FooterRetur> {
  @override
  Widget build(BuildContext context) {
    ReturController controller = widget.controller;
    return Container(
      decoration: BoxDecoration(
        color: gray100,
        border: Border.all(
          width: 1.0,
          color: blueGray50,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Container(
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
            Container(
              width: 60,
              padding: const EdgeInsets.all(8),
              child: Text(
                formatMoney(controller.dataPayloadRetur.jumlah ?? "0"),
                textAlign: TextAlign.center,
                style: myTextTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w600,
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
                formatMoney(controller.dataPayloadRetur.totalNilaiBeli ?? "0"),
                textAlign: TextAlign.end,
                style: myTextTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
