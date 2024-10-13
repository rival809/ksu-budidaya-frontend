// ignore_for_file: camel_case_types
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ksu_budidaya/core.dart';

class DialogTambahPembelian extends StatefulWidget {
  final DataDetailPembelian? data;
  final PembelianController controller;
  final bool? isDetail;
  const DialogTambahPembelian({
    required this.data,
    required this.controller,
    this.isDetail,
    Key? key,
  }) : super(key: key);

  @override
  State<DialogTambahPembelian> createState() => _DialogTambahPembelianState();
}

class _DialogTambahPembelianState extends State<DialogTambahPembelian> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void initState() {
    dataEdit = widget.data?.copyWith() ?? DataDetailPembelian();
    textController[0].text = trimString(widget.data?.idProduct);
    textController[1].text = trimString(widget.data?.nmProduk);
    textController[2].text = trimString(widget.data?.jumlah.toString());
    textController[3].text = formatMoney(trimString(widget.data?.hargaBeli));
    textController[4].text = formatMoney(trimString(widget.data?.hargaJual));
    textController[5].text =
        formatMoney(trimString(widget.data?.diskon ?? "0"));
    dataEdit.diskon = widget.data?.diskon ?? "0";
    dataEdit.nmDivisi = trimString(widget.data?.nmDivisi).toString().isNotEmpty
        ? trimString(widget.data?.nmDivisi)
        : null;
    if (int.parse(dataEdit.diskon ?? "0") < 100) {
      jenisDiskon = "Persen";
    } else {
      jenisDiskon = "Nominal";
    }
    for (var i = 0;
        i < (DivisiDatabase.dataDivisi.dataDivisi?.length ?? 0);
        i++) {
      itemDivisi
          .add(trimString(DivisiDatabase.dataDivisi.dataDivisi?[i].nmDivisi));
    }
    super.initState();
  }

  String? jenisDiskon;
  List<String> itemDivisi = [];

  @override
  void dispose() {
    textController[0].dispose();
    textController[1].dispose();
    textController[2].dispose();
    textController[3].dispose();
    textController[4].dispose();
    textController[5].dispose();
    super.dispose();
  }

  DataDetailPembelian dataEdit = DataDetailPembelian();

  final tambahPembelianKey = GlobalKey<FormState>();

  Timer? _debounce;
  void onBarcodeChanged(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(
      const Duration(seconds: 2),
      () {
        if (textController[0].text.isNotEmpty) {
          postDetailProduct(value);
        }
      },
    );
  }

  DetailProductResult dataResult = DetailProductResult();

  postDetailProduct(String idProduct) async {
    showCircleDialogLoading();
    try {
      dataResult = DetailProductResult();

      DetailProductResult result = await ApiService.detailProduct(
        data: {"id_product": idProduct},
      ).timeout(const Duration(seconds: 30));
      Navigator.pop(context);

      if (result.success == true) {
        dataResult = result;
        textController[0].text = trimString(result.data?.idProduct);
        dataEdit.idProduct = trimString(result.data?.idProduct);
        textController[1].text = trimString(result.data?.nmProduct);
        dataEdit.nmProduk = trimString(result.data?.nmProduct);
        textController[2].text = trimString(result.data?.jumlah.toString());
        dataEdit.jumlah = result.data?.jumlah;
        textController[3].text =
            formatMoney(trimString(result.data?.hargaBeli));
        dataEdit.hargaBeli = trimString(result.data?.hargaBeli);
        textController[4].text =
            formatMoney(trimString(result.data?.hargaJual));
        dataEdit.hargaJual = trimString(result.data?.hargaJual);

        dataEdit.nmDivisi = trimString(result.data?.idDivisi).toString().isEmpty
            ? null
            : getNamaDivisi(idDivisi: result.data?.idDivisi);

        update();
      }
    } catch (e) {
      Navigator.pop(context);

      // if (e.toString().contains("TimeoutException")) {
      //   showInfoDialog(
      //       "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      // } else {
      //   showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    PembelianController controller = widget.controller;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: tambahPembelianKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isDetail ?? false ? "Detail Produk" : "Tambah Produk",
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
                  enabled: controller.isDetail ? false : true,
                  label: "ID",
                  autoFocus: true,
                  hintText: "Masukkan ID Product",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  textEditingController: textController[0],
                  onChanged: (value) {
                    dataEdit.idProduct = trimString(value);
                    onBarcodeChanged(value);
                    update();
                  },
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                BaseForm(
                  label: "Nama Produk",
                  enabled: false,
                  hintText: "Masukkan Nama Produk",
                  textInputFormater: [
                    UpperCaseTextFormatter(),
                  ],
                  textEditingController: textController[1],
                  onChanged: (value) {
                    dataEdit.nmProduk = trimString(value);
                    update();
                  },
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                SimpleDropdownButton(
                  hint: "Pilih Divisi",
                  label: "Divisi",
                  items: itemDivisi,
                  enabled: false,
                  value: dataEdit.nmDivisi,
                  onChanged: (value) {
                    dataEdit.nmDivisi = value;
                    update();
                  },
                ),
                BaseForm(
                  enabled: controller.isDetail ? false : true,
                  label: "Jumlah",
                  hintText: "Masukkan Jumlah",
                  textEditingController: textController[2],
                  onChanged: (value) {
                    dataEdit.jumlah =
                        int.tryParse(removeComma(trimString(value)));
                    update();
                  },
                  textInputFormater: [
                    ThousandsFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                BaseForm(
                  enabled: controller.isDetail ? false : true,
                  label: "Harga Jual",
                  hintText: "Masukkan Harga Jual",
                  prefix: const BasePrefixRupiah(),
                  textEditingController: textController[3],
                  onChanged: (value) {
                    dataEdit.hargaJual = removeComma(trimString(value));
                    update();
                  },
                  textInputFormater: [
                    ThousandsFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                BaseForm(
                  enabled: controller.isDetail ? false : true,
                  label: "Harga Beli",
                  hintText: "Masukkan Harga Beli",
                  prefix: const BasePrefixRupiah(),
                  textEditingController: textController[4],
                  onChanged: (value) {
                    dataEdit.hargaBeli = removeComma(trimString(value));
                    update();
                  },
                  textInputFormater: [
                    ThousandsFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  validator: Validatorless.required("Data Wajib Diisi"),
                ),
                SimpleDropdownButton(
                  enabled: controller.isDetail ? false : true,
                  label: "Jenis Diskon",
                  hint: "Pilih Jenis Diskon",
                  items: const ["Nominal", "Persen"],
                  value: jenisDiskon,
                  onChanged: (value) {
                    jenisDiskon = value;
                    update();
                  },
                ),
                BaseForm(
                  enabled: controller.isDetail ? false : true,
                  label: "Diskon",
                  prefix: jenisDiskon == "Nominal"
                      ? const BasePrefixRupiah()
                      : null,
                  hintText: "Masukkan Diskon",
                  textInputFormater: [
                    ThousandsFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  textEditingController: textController[5],
                  onChanged: (value) {
                    dataEdit.diskon = trimString(removeComma(value));
                    update();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
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
                if (!controller.isDetail)
                  Expanded(
                    child: BaseDangerButton(
                      text: "Hapus",
                      onPressed: controller.isDetail
                          ? null
                          : () {
                              controller.dataPembelian.details?.removeWhere(
                                  (element) =>
                                      trimString(element.idDetailPembelian
                                          .toString()) ==
                                      trimString(widget.data?.idDetailPembelian
                                          .toString()));
                              controller.update();
                              Get.back();
                            },
                    ),
                  ),
                if (!controller.isDetail)
                  const SizedBox(
                    width: 16.0,
                  ),
                Expanded(
                  child: BasePrimaryButton(
                    text: "Simpan",
                    onPressed: controller.isDetail
                        ? null
                        : () {
                            try {
                              if (tambahPembelianKey.currentState!.validate()) {
                                dataEdit.ppn = "0";
                                DataMap payload = dataEdit.toJson();
                                payload.removeWhere(
                                  (key, value) => key == "created_at",
                                );
                                payload.removeWhere(
                                  (key, value) => key == "updated_at",
                                );
                                payload.removeWhere(
                                  (key, value) => key == "id_pembelian",
                                );
                                if (jenisDiskon == "Persen") {
                                  payload.update("diskon", (value) {
                                    return roundDouble((double.parse(
                                                dataEdit.hargaBeli ?? "0") *
                                            ((double.parse(value ?? "0")) /
                                                100) *
                                            (dataEdit.jumlah ?? 0)))
                                        .toString();
                                  });
                                } else if (jenisDiskon == "Nominal") {
                                  payload.update("diskon", (value) {
                                    return trimString(value ?? "0");
                                  });
                                }
                                payload.update("total_nilai_beli", (value) {
                                  return (double.parse(
                                                  dataEdit.hargaBeli ?? "0") *
                                              (dataEdit.jumlah ?? 0) -
                                          double.parse(
                                              payload["diskon"] ?? "0"))
                                      .round()
                                      .toString();
                                });
                                payload.update("total_nilai_jual", (value) {
                                  return (double.parse(
                                              dataEdit.hargaJual ?? "0") *
                                          (dataEdit.jumlah ?? 0))
                                      .round()
                                      .toString();
                                });
                                if (widget.isDetail ?? false) {
                                  payload.update(
                                    "id_detail_pembelian",
                                    (value) => widget.data?.idDetailPembelian,
                                  );
                                  controller.dataPembelian.details?.removeWhere(
                                      (element) =>
                                          trimString(element.idDetailPembelian
                                              .toString()) ==
                                          trimString(widget
                                              .data?.idDetailPembelian
                                              .toString()));
                                  controller.update();

                                  DataDetailPembelian dataPayload =
                                      DataDetailPembelian.fromJson(payload);
                                  controller.dataPembelian.details
                                      ?.add(dataPayload);
                                  controller.update();
                                } else {
                                  payload.update(
                                    "id_detail_pembelian",
                                    (value) =>
                                        controller
                                            .dataPembelian.details?.length ??
                                        0,
                                  );

                                  DataDetailPembelian dataPayload =
                                      DataDetailPembelian.fromJson(payload);

                                  controller.dataPembelian.details
                                      ?.add(dataPayload);
                                  controller.update();
                                }

                                Get.back();
                              }
                            } catch (e) {
                              showInfoDialog(e.toString(), context);
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
