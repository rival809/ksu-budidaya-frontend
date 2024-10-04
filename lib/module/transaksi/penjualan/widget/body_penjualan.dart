// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class BodyPenjualan extends StatefulWidget {
  final int index;
  final PenjualanController controller;
  const BodyPenjualan({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  State<BodyPenjualan> createState() => _BodyPenjualanState();
}

class _BodyPenjualanState extends State<BodyPenjualan> {
  @override
  Widget build(BuildContext context) {
    PenjualanController controller = widget.controller;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: blueGray50,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  controller.dataPenjualan.details?.removeAt(widget.index);
                  controller.update();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 1.0,
                        color: blueGray50,
                      ),
                    ),
                  ),
                  child: SvgPicture.asset(
                    iconDelete,
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
                padding: const EdgeInsets.all(8),
                child: Text(
                  trimString(
                    controller.dataPenjualan.details?[widget.index].idProduct,
                  ),
                  style: myTextTheme.bodyMedium,
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
                padding: const EdgeInsets.all(8),
                child: Text(
                  trimString(
                    controller.dataPenjualan.details?[widget.index].nmProduk,
                  ),
                  style: myTextTheme.bodyMedium,
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
                padding: const EdgeInsets.all(8),
                child: Text(
                  trimString(
                    controller.dataPenjualan.details?[widget.index].harga,
                  ),
                  style: myTextTheme.bodyMedium,
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
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        trimString(
                          controller
                              .dataPenjualan.details?[widget.index].jumlah,
                        ),
                        style: myTextTheme.bodyMedium,
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.dataPenjualan.details?[widget.index]
                                .jumlah = (int.parse(controller.dataPenjualan
                                            .details?[widget.index].jumlah ??
                                        "0") +
                                    1)
                                .toString();
                            controller.update();
                          },
                          child: SvgPicture.asset(
                            iconArrowDropUp,
                            height: 16,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (int.parse(controller.dataPenjualan
                                        .details?[widget.index].jumlah ??
                                    "1") >=
                                1) {
                              controller.dataPenjualan.details?[widget.index]
                                  .jumlah = (int.parse(controller.dataPenjualan
                                              .details?[widget.index].jumlah ??
                                          "0") -
                                      1)
                                  .toString();
                              controller.update();
                            }
                          },
                          child: SvgPicture.asset(
                            iconArrowDropDown,
                            height: 16,
                          ),
                        )
                      ],
                    ),
                  ],
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
                padding: const EdgeInsets.all(8),
                child: Text(
                  trimString(
                    controller.dataPenjualan.details?[widget.index].diskon,
                  ),
                  style: myTextTheme.bodyMedium,
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
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 1.0,
                      color: blueGray50,
                    ),
                  ),
                ),
                child: Text(
                  trimString(
                    controller.dataPenjualan.details?[widget.index].total,
                  ),
                  style: myTextTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
