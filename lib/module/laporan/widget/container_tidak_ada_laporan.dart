// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ContainerTidakAdaLaporan extends StatefulWidget {
  const ContainerTidakAdaLaporan({
    Key? key,
  }) : super(key: key);

  @override
  State<ContainerTidakAdaLaporan> createState() =>
      _ContainerTidakAdaLaporanState();
}

class _ContainerTidakAdaLaporanState extends State<ContainerTidakAdaLaporan> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => Container(
        constraints: BoxConstraints.loose(
          Size.fromHeight(
            MediaQuery.of(context).size.height -
                144 -
                64 -
                AppBar().preferredSize.height -
                32,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
            width: 1.0,
            color: blueGray50,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset(
                iconScanDelete,
                height: 32,
                width: 32,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Data Tidak Ditemukan ",
                    style: myTextTheme.bodyLarge?.copyWith(
                      color: gray700,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      desktop: (context) => Container(
        constraints: BoxConstraints.loose(
          Size.fromHeight(
            MediaQuery.of(context).size.height -
                120 -
                64 -
                AppBar().preferredSize.height -
                40,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
            width: 1.0,
            color: blueGray50,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset(
                iconScanDelete,
                height: 32,
                width: 32,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Data Tidak Ditemukan ",
                    style: myTextTheme.bodyLarge?.copyWith(
                      color: gray700,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
