// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:ksu_budidaya/module/transaksi/hist_bayar_hutang_anggota/controller/hist_bayar_hutang_anggota_controller.dart';

class BodyPenjualanHist extends StatefulWidget {
  final int index;
  final HistBayarHutangAnggotaController controller;
  const BodyPenjualanHist({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  State<BodyPenjualanHist> createState() => _BodyPenjualanHistState();
}

class _BodyPenjualanHistState extends State<BodyPenjualanHist> {
  TextEditingController diskonController = TextEditingController();
  TextEditingController qntController = TextEditingController();

  String persenDiskon = "0";
  String totalHarga = "0";

  hitDiskon() {
    var diskon = double.parse(
      removeComma(
        widget.controller.dataPenjualan.details?[widget.index].diskon ?? "0",
      ),
    );

    var hargaJual = double.parse(
      removeComma(
        widget.controller.dataPenjualan.details?[widget.index].harga ?? "0",
      ),
    );

    if (hargaJual == 0) {
      persenDiskon = "0";
    } else {
      persenDiskon = formatMoney(
        (((hargaJual - (hargaJual - diskon)) / hargaJual) * 100).round().toString(),
      );
    }

    diskonController.text = trimString(persenDiskon);
  }

  @override
  void initState() {
    super.initState();
    hitDiskon();
    diskonController.text = trimString(persenDiskon);

    qntController.text = trimString(widget.controller.dataPenjualan.details?[widget.index].jumlah);
  }

  @override
  Widget build(BuildContext context) {
    HistBayarHutangAnggotaController controller = widget.controller;
    controller.sumTotalIndex();

    double harga =
        double.tryParse(controller.dataPenjualan.details?[widget.index].harga ?? "0") ?? 0;
    double diskon =
        double.tryParse(controller.dataPenjualan.details?[widget.index].diskon ?? "0") ?? 0;
    double jumlah =
        double.tryParse(controller.dataPenjualan.details?[widget.index].jumlah ?? "0") ?? 0;

    double total = ((harga - diskon) * jumlah);

    if (trimString(qntController.text) != jumlah.toString()) {
      qntController.text = jumlah.toString();
    }

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
                      child: BaseForm(
                        textEditingController: qntController,
                        readOnly: true,
                        onChanged: (value) {
                          String trimmedValue = removeComma(trimString(value));

                          double? inputValue = double.tryParse(trimmedValue);

                          if (inputValue != null) {
                            if (inputValue < 1) {
                              inputValue = 1;
                              qntController.text = "1";
                            }

                            widget.controller.dataPenjualan.details?[widget.index].jumlah =
                                inputValue.toString();
                          } else {
                            widget.controller.dataPenjualan.details?[widget.index].jumlah = "1";
                            qntController.text = "1";
                          }

                          controller.update();
                        },
                        textInputFormater: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ThousandsFormatter(),
                        ],
                        validator: Validatorless.required("minimal 1"),
                        autoValidate: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: null,
                          child: SvgPicture.asset(
                            iconArrowDropUp,
                            height: 16,
                          ),
                        ),
                        InkWell(
                          onTap: null,
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
                    controller.update();
                  },
                  readOnly: true,
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
                        removeComma(
                            widget.controller.dataPenjualan.details?[widget.index].harga ?? "0"),
                      );

                      var nilaiDiskon = ((inputValue / 100) * hargaJual).round();

                      widget.controller.dataPenjualan.details?[widget.index].diskon =
                          nilaiDiskon.toString();
                    } else {
                      widget.controller.dataPenjualan.details?[widget.index].diskon = "0";
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
                      ((harga - diskon) * jumlah).toString(),
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
