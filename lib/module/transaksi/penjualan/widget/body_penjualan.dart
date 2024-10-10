// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController diskonController = TextEditingController();
  TextEditingController qntController = TextEditingController();

  String persenDiskon = "0";
  String totalHarga = "0";

  hitDiskon() {
    var diskon = double.parse(
      removeComma(
          widget.controller.dataPenjualan.details?[widget.index].diskon ?? "0"),
    );

    var hargaJual = double.parse(
      removeComma(
          widget.controller.dataPenjualan.details?[widget.index].harga ?? "0"),
    );

    persenDiskon = formatMoney(
        (((hargaJual - (hargaJual - diskon)) / hargaJual) * 100).toString());

    diskonController.text = trimString(persenDiskon);
  }

  @override
  void initState() {
    super.initState();
    diskonController.text = trimString(persenDiskon);

    qntController.text = trimString(
        widget.controller.dataPenjualan.details?[widget.index].jumlah);
  }

  @override
  Widget build(BuildContext context) {
    PenjualanController controller = widget.controller;
    controller.sumTotalIndex();
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
                  controller.focusNodeInputPenjualan.requestFocus();
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
                    colorFilter: colorFilterRed800,
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
                  formatMoney(
                    trimString(
                      controller.dataPenjualan.details?[widget.index].harga,
                    ),
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
                            controller.focusNodeInputPenjualan.requestFocus();

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
                                    "1") >
                                1) {
                              controller.dataPenjualan.details?[widget.index]
                                  .jumlah = (int.parse(controller.dataPenjualan
                                              .details?[widget.index].jumlah ??
                                          "0") -
                                      1)
                                  .toString();
                              controller.dataPenjualan.details?[widget.index]
                                  .total = ((double.parse(controller.dataPenjualan.details?[widget.index].harga ?? "0") *
                                          double.parse(controller
                                                  .dataPenjualan
                                                  .details?[widget.index]
                                                  .jumlah ??
                                              "0")) -
                                      (double.parse(controller.dataPenjualan.details?[widget.index].harga ?? "0") *
                                              double.parse(controller
                                                      .dataPenjualan
                                                      .details?[widget.index]
                                                      .jumlah ??
                                                  "0")) *
                                          (double.parse(controller.dataPenjualan.details?[widget.index].diskon ?? "0") /
                                              100))
                                  .toString();
                              controller.focusNodeInputPenjualan.requestFocus();
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
                child: BaseForm(
                  textEditingController: diskonController,
                  onEditComplete: () {
                    controller.focusNodeInputPenjualan.requestFocus();
                    controller.update();
                  },
                  onChanged: (value) {
                    String trimmedValue = trimString(value);

                    double? inputValue = double.tryParse(trimmedValue);

                    if (inputValue != null) {
                      if (inputValue < 0) {
                        inputValue = 0;
                      } else if (inputValue > 100) {
                        inputValue = 100;
                      }

                      var hargaJual = double.parse(
                        removeComma(widget.controller.dataPenjualan
                                .details?[widget.index].harga ??
                            "0"),
                      );

                      var nilaiDiskon = (inputValue / 100) * hargaJual;

                      widget.controller.dataPenjualan.details?[widget.index]
                          .diskon = nilaiDiskon.toString();
                    } else {
                      widget.controller.dataPenjualan.details?[widget.index]
                          .diskon = "0";
                    }

                    controller.update();
                  },
                  maxLenght: 3,
                  textInputFormater: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ThousandsFormatter()
                  ],
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
                  formatMoney(
                    trimString(
                      ((double.parse(controller.dataPenjualan
                                          .details?[widget.index].harga ??
                                      "0") -
                                  double.parse(controller.dataPenjualan
                                          .details?[widget.index].diskon ??
                                      "0")) *
                              double.parse(controller.dataPenjualan
                                      .details?[widget.index].jumlah ??
                                  "0"))
                          .toString(),
                    ),
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
