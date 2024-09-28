// ignore_for_file: camel_case_types
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ksu_budidaya/core.dart';

class DialogTambahPembelian extends StatefulWidget {
  final DataDetailPembelian? data;
  // final Function()? onPressedRight;
  // final Function()? onPressedLeft;
  const DialogTambahPembelian({
    required this.data,
    // required this.onPressedRight,
    // required this.onPressedLeft,
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
    textController[5].text = formatMoney(trimString(widget.data?.diskon));
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
        postDetailProduct(value);
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
        textController[1].text = trimString(result.data?.nmProduct);
        textController[2].text = trimString(result.data?.jumlah.toString());
        textController[3].text =
            formatMoney(trimString(result.data?.hargaBeli));
        textController[4].text =
            formatMoney(trimString(result.data?.hargaJual));

        dataEdit.nmDivisi = trimString(result.data?.idDivisi).toString().isEmpty
            ? null
            : getNamaDivisi(idDivisi: result.data?.idDivisi);

        update();
      }
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: tambahPembelianKey,
        child: Column(
          children: [
            Text(
              "Tambah Produk",
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
                  value: dataEdit.nmDivisi,
                  onChanged: (value) {
                    dataEdit.nmDivisi = value;
                    update();
                  },
                ),
                BaseForm(
                  label: "Jumlah",
                  hintText: "Masukkan Jumlah",
                  prefix: const BasePrefixRupiah(),
                  textEditingController: textController[2],
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
                  label: "Diskon",
                  prefix: jenisDiskon == "Nominal"
                      ? const BasePrefixRupiah()
                      : null,
                  hintText: "Masukkan Diskon",
                  textInputFormater: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textEditingController: textController[5],
                  onChanged: (value) {
                    dataEdit.diskon = trimString(value);
                    update();
                  },
                  validator: Validatorless.required("Data Wajib Diisi"),
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
                Expanded(
                  child: BasePrimaryButton(
                    text: "Simpan",
                    onPressed: () {
                      if (tambahPembelianKey.currentState!.validate()) {
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
