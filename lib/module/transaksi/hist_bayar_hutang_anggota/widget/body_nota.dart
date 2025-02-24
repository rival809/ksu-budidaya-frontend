// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/module/transaksi/hist_bayar_hutang_anggota/controller/hist_bayar_hutang_anggota_controller.dart';

class BodyNotaHist extends StatefulWidget {
  final int index;
  final HistBayarHutangAnggotaController controller;
  const BodyNotaHist({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  State<BodyNotaHist> createState() => _BodyNotaHistState();
}

class _BodyNotaHistState extends State<BodyNotaHist> {
  String persenDiskon = "0";

  hitDiskon() {
    var diskon = double.tryParse(
          removeComma(widget.controller.dataPenjualan.details?[widget.index].diskon ?? "0"),
        ) ??
        0;

    var hargaJual = double.tryParse(
          removeComma(widget.controller.dataPenjualan.details?[widget.index].harga ?? "0"),
        ) ??
        0;

    if (hargaJual > 0) {
      persenDiskon = (((hargaJual - (hargaJual - diskon)) / hargaJual) * 100).round().toString();
    } else {
      persenDiskon = "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    HistBayarHutangAnggotaController controller = widget.controller;
    hitDiskon();
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  trimString(
                    controller.dataPenjualan.details?[widget.index].nmProduk,
                  ),
                  style: myTextTheme.bodySmall,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              trimString(
                                    controller.dataPenjualan.details?[widget.index].jumlah,
                                  ) +
                                  "x",
                              style: myTextTheme.bodySmall,
                            ),
                          ),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: Text(
                              formatMoney(trimString(
                                controller.dataPenjualan.details?[widget.index].harga,
                              )),
                              style: myTextTheme.bodySmall,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        formatMoney(trimString(
                          ((double.parse(controller.dataPenjualan.details?[widget.index].harga ??
                                      "0") *
                                  double.parse(
                                      controller.dataPenjualan.details?[widget.index].jumlah ??
                                          "0")))
                              .toString(),
                        )),
                        style: myTextTheme.bodySmall,
                        textAlign: TextAlign.end,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          if (controller.dataPenjualan.details?[widget.index].diskon != "0")
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Diskon",
                    style: myTextTheme.bodySmall,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "",
                                style: myTextTheme.bodySmall,
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              child: Text(
                                trimString(persenDiskon) + "%",
                                textAlign: TextAlign.start,
                                style: myTextTheme.bodySmall,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          formatMoney(
                            trimString(
                              (double.parse(
                                          controller.dataPenjualan.details?[widget.index].diskon ??
                                              "0") *
                                      double.parse(removeComma(widget.controller.dataPenjualan
                                              .details?[widget.index].jumlah ??
                                          "0")))
                                  .toString(),
                            ),
                          ),
                          style: myTextTheme.bodySmall,
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
