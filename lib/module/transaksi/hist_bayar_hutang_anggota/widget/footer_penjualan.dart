// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/module/transaksi/hist_bayar_hutang_anggota/controller/hist_bayar_hutang_anggota_controller.dart';

class FooterPenjualanHist extends StatefulWidget {
  final HistBayarHutangAnggotaController controller;

  const FooterPenjualanHist({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<FooterPenjualanHist> createState() => _FooterPenjualanHistState();
}

class _FooterPenjualanHistState extends State<FooterPenjualanHist> {
  @override
  Widget build(BuildContext context) {
    HistBayarHutangAnggotaController controller = widget.controller;

    controller.sumTotal();

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
              flex: 6,
              child: Container(
                decoration: const BoxDecoration(
                  color: gray100,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                  ),
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
                  formatMoney(trimString(controller.dataPenjualan.totalNilaiJual)),
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
