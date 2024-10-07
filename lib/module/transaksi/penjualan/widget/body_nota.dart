// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/shared/util/trim_string/trim_string.dart';

class BodyNota extends StatefulWidget {
  final int index;
  final PenjualanController controller;
  const BodyNota({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  State<BodyNota> createState() => _BodyNotaState();
}

class _BodyNotaState extends State<BodyNota> {
  @override
  Widget build(BuildContext context) {
    PenjualanController controller = widget.controller;
    return Column(
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
                                  controller.dataPenjualan
                                      .details?[widget.index].jumlah,
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
                              controller
                                  .dataPenjualan.details?[widget.index].harga,
                            )),
                            style: myTextTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      trimString(
                        ((double.parse(controller.dataPenjualan
                                        .details?[widget.index].harga ??
                                    "0") *
                                double.parse(controller.dataPenjualan
                                        .details?[widget.index].jumlah ??
                                    "0")))
                            .toString(),
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
                              trimString(
                                    controller.dataPenjualan
                                        .details?[widget.index].diskon,
                                  ) +
                                  "%",
                              textAlign: TextAlign.start,
                              style: myTextTheme.bodySmall,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        trimString(
                          ((double.parse(controller.dataPenjualan
                                              .details?[widget.index].harga ??
                                          "0") *
                                      double.parse(controller.dataPenjualan
                                              .details?[widget.index].jumlah ??
                                          "0")) *
                                  (double.parse(controller.dataPenjualan
                                              .details?[widget.index].diskon ??
                                          "0") /
                                      100))
                              .toString(),
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
    );
  }
}
