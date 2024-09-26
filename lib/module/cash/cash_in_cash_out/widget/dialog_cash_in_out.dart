// ignore_for_file: camel_case_types
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ksu_budidaya/core.dart';

class DialogCashInOut extends StatefulWidget {
  final DataDetailCashInOut? data;
  final bool isDetail;

  const DialogCashInOut({
    Key? key,
    required this.isDetail,
    required this.data,
  }) : super(key: key);

  @override
  State<DialogCashInOut> createState() => _DialogCashInOutState();
}

class _DialogCashInOutState extends State<DialogCashInOut> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  DataDetailCashInOut dataEdit = DataDetailCashInOut();

  final cashInOutKey = GlobalKey<FormState>();

  @override
  void initState() {
    dataEdit = widget.data?.copyWith() ?? DataDetailCashInOut();
    textController[0].text = formatDate(trimString(dataEdit.tgTransaksi));
    textController[1].text = formatMoney(trimString(dataEdit.nominal));
    textController[2].text = trimString(dataEdit.keterangan);
    if (dataEdit.idCash?.isNotEmpty ?? false) {
      jenisReference(idCash: dataEdit.idCash);
    }
    if (trimString(dataEdit.idCash).toString().isNotEmpty &&
        trimString(dataEdit.idJenis.toString()).toString().isNotEmpty) {
      detailReference(
        idCash: dataEdit.idCash,
        idJenis: dataEdit.idJenis.toString(),
      );
    }
    valueDetail = trimString(dataEdit.idDetail.toString()).toString().isEmpty
        ? null
        : "${trimString(dataEdit.idDetail.toString())} - ${trimString(dataEdit.nmDetail)}";
    valueJenis = trimString(dataEdit.idJenis.toString()).toString().isEmpty
        ? null
        : "${trimString(dataEdit.idJenis.toString())} - ${trimString(dataEdit.nmJenis)}";

    super.initState();
  }

  @override
  void dispose() {
    textController[0].dispose();
    textController[1].dispose();
    textController[2].dispose();
    super.dispose();
  }

  RefJenisCashResult responRefJenis = RefJenisCashResult();
  RefDetailCashResult responRefDetail = RefDetailCashResult();

  List<String> dataRefDetail = [];
  List<String> dataRefJenis = [];

  String? valueJenis;
  String? valueDetail;

  jenisReference({String? idCash}) async {
    dataRefJenis = [];
    responRefJenis = RefJenisCashResult();

    try {
      RefJenisCashResult result = await ApiService.listRefJenis(
        data: {
          "id_cash": trimString(idCash),
        },
      ).timeout(const Duration(seconds: 30));

      for (var i = 0; i < (result.data?.length ?? 0); i++) {
        dataRefJenis.add(
          "${trimString(result.data?[i].idJenis.toString())} - ${trimString(result.data?[i].nmJenis)}",
        );
      }

      responRefJenis = result;
    } catch (e) {
      log(e.toString());
    }
  }

  detailReference({String? idCash, String? idJenis}) async {
    dataRefDetail = [];
    responRefDetail = RefDetailCashResult();

    try {
      RefDetailCashResult result = await ApiService.listRefDetail(
        data: {
          "id_cash": trimString(idCash),
          "id_jenis": trimString(idJenis),
        },
      ).timeout(const Duration(seconds: 30));

      for (var i = 0; i < (result.data?.length ?? 0); i++) {
        dataRefDetail.add(
          "${trimString(result.data?[i].idDetail.toString())} - ${trimString(result.data?[i].nmDetail)}",
        );
      }

      responRefDetail = result;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: cashInOutKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isDetail ? "Ubah Data" : "Tambah Data",
              style: myTextTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            StaggeredGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                BaseForm(
                  prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      iconCalendarMonth,
                      height: 16,
                      colorFilter: colorFilterPrimary,
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? selectedDate = await initSelectedDate(
                      initValue: dataEdit.tgTransaksi,
                    );

                    if (selectedDate != null) {
                      dataEdit.tgTransaksi = selectedDate.toString();
                      textController[0].text =
                          formatDate(selectedDate.toString());
                      update();
                    }
                  },
                  label: "Tanggal Transaksi",
                  hintText: "Masukkan Tanggal Transaksi",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: Validatorless.required("Data Wajib Diisi"),
                  autoValidate: AutovalidateMode.onUserInteraction,
                  textEditingController: textController[0],
                  enabled: true,
                ),
                BaseDropdownButton<DataRefCash>(
                  hint: "Pilih Jenis Cash",
                  enabled: true,
                  label: "Jenis Cash",
                  itemAsString: (item) => item.cashAsString(),
                  items: RefCashDatabase.refCashResult.data ?? [],
                  value: trimString(dataEdit.idCash).toString().isEmpty
                      ? null
                      : DataRefCash(
                          idCash: widget.data?.idCash,
                          nmCash: trimString(
                            getNamaCash(
                              idCash: trimString(
                                widget.data?.idCash,
                              ),
                            ),
                          ),
                        ),
                  onChanged: (value) async {
                    dataEdit.idCash = trimString(value?.idCash);
                    dataEdit.idJenis = null;
                    dataEdit.idDetail = null;
                    dataEdit.nmDetail = null;
                    dataEdit.nmJenis = null;
                    update();
                    valueDetail = null;
                    valueJenis = null;

                    update();

                    await jenisReference(idCash: trimString(value?.idCash));
                    update();
                  },
                  validator: Validatorless.required("Data Wajib Diisi"),
                  autoValidate: AutovalidateMode.onUserInteraction,
                ),
                SimpleDropdownButton(
                  hint: "Pilih Detail Jenis Transaksi",
                  enabled: trimString(dataEdit.idJenis.toString())
                          .toString()
                          .isNotEmpty
                      ? true
                      : false,
                  label: "Detail Jenis Transaksi",
                  items: dataRefDetail,
                  value: trimString(dataEdit.idDetail.toString())
                          .toString()
                          .isEmpty
                      ? null
                      : valueDetail,
                  validator: Validatorless.required("Data Wajib Diisi"),
                  autoValidate: AutovalidateMode.onUserInteraction,
                  onChanged: (value) async {
                    valueDetail = value;
                    update();

                    dataEdit.idDetail =
                        int.tryParse(trimString(splitString(value, true)));
                    dataEdit.nmDetail = trimString(splitString(value, false));

                    update();
                  },
                ),
                SimpleDropdownButton(
                  hint: "Pilih Jenis Transaksi",
                  enabled: trimString(dataEdit.idCash.toString())
                          .toString()
                          .isNotEmpty
                      ? true
                      : false,
                  label: "Jenis Transaksi",
                  items: dataRefJenis,
                  value:
                      trimString(dataEdit.idJenis.toString()).toString().isEmpty
                          ? null
                          : valueJenis,
                  validator: Validatorless.required("Data Wajib Diisi"),
                  autoValidate: AutovalidateMode.onUserInteraction,
                  onChanged: (value) async {
                    valueJenis = value;
                    dataEdit.idDetail = null;
                    dataEdit.nmDetail = null;
                    valueDetail = null;
                    update();

                    dataEdit.idJenis =
                        int.tryParse(trimString(splitString(value, true)));
                    dataEdit.nmJenis = trimString(splitString(value, false));

                    update();
                    await detailReference(
                      idCash: trimString(dataEdit.idCash),
                      idJenis: dataEdit.idJenis.toString(),
                    );
                    update();
                  },
                ),
                Container(),
                BaseForm(
                  prefix: const BasePrefixRupiah(),
                  label: "Nominal",
                  hintText: "Masukkan Nominal",
                  textInputFormater: [
                    ThousandsFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  onChanged: (value) {
                    dataEdit.nominal = removeComma(trimString(value));
                    update();
                  },
                  textEditingController: textController[1],
                  enabled: true,
                  validator: Validatorless.required("Data Wajib Diisi"),
                  autoValidate: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            BaseForm(
              label: "Keterangan",
              hintText: "Masukkan Keterangan",
              textEditingController: textController[2],
              onChanged: (value) {
                dataEdit.keterangan = trimString(value);
                update();
              },
              enabled: true,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: BaseSecondaryButton(
                    text: "Batal",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BasePrimaryButton(
                    text: "Simpan",
                    onPressed: () {
                      print(dataEdit.toJson());
                      if (cashInOutKey.currentState!.validate()) {
                        DataMap payload = dataEdit.toJson();
                        payload.removeWhere(
                          (key, value) => key == "created_at",
                        );
                        payload.removeWhere(
                          (key, value) => key == "updated_at",
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
