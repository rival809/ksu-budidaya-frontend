// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksu_budidaya/core.dart';

class DialogTambahRetur extends StatefulWidget {
  final ReturController controller;
  final bool? isDetail;
  final int? index;
  final DetailsReturPayload? data;

  const DialogTambahRetur({
    Key? key,
    required this.data,
    this.isDetail,
    this.index,
    required this.controller,
  }) : super(key: key);

  @override
  State<DialogTambahRetur> createState() => _DialogTambahReturState();
}

class _DialogTambahReturState extends State<DialogTambahRetur> {
  List<TextEditingController> textController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final tambahReturKey = GlobalKey<FormState>();

  List<DetailDataPembelian> getSuggestions(String query, List<DetailDataPembelian>? states) {
    List<DetailDataPembelian> matches = [];

    if (states != null) {
      matches.addAll(states);
      matches.retainWhere(
          (s) => trimString(s.idPembelian).toLowerCase().contains(query.toLowerCase()));
    }

    return matches;
  }

  List<DetailPurchase> getDetailSuggestions(String query, List<DetailPurchase>? states) {
    List<DetailPurchase> matches = [];

    if (states != null) {
      matches.addAll(states);
      matches
          .retainWhere((s) => trimString(s.idProduct).toLowerCase().contains(query.toLowerCase()));
    }

    return matches;
  }

  cariDataPembelian() async {
    try {
      resultPembelian = PembelianResult();

      PembelianResult result = await ApiService.listPembelian(
        data: {},
      ).timeout(const Duration(seconds: 30));

      resultPembelian = await ApiService.listPembelian(
        data: {
          "page": "1",
          "size": result.data?.paging?.totalItem,
        },
      ).timeout(const Duration(seconds: 30));
      update();
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  cariDetailPembelian(String idPembelian) async {
    try {
      detailPembelian = DetailPembelianResult();

      detailPembelian = await ApiService.detailPembelian(
        data: {"id_pembelian": idPembelian},
      ).timeout(const Duration(seconds: 30));

      update();
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  PembelianResult resultPembelian = PembelianResult();
  DetailPembelianResult detailPembelian = DetailPembelianResult();
  DetailPurchase selectedDetailPembelian = DetailPurchase();

  onInitState() async {
    await cariDataPembelian();
    if (widget.controller.dataPayloadRetur.idPembelian?.isNotEmpty ?? false) {
      await cariDetailPembelian(trimString(widget.controller.dataPayloadRetur.idPembelian));
    }
    if (widget.index != null) {
      selectedDetailPembelian = detailPembelian.data!.detailPurchase!.firstWhere(
          (element) => trimString(element.idProduct) == trimString(widget.data?.idProduct));
    }
    textController[0].text = trimString(widget.controller.dataPayloadRetur.idPembelian);
    textController[1].text = trimString(widget.data?.idProduct);
    textController[2].text = trimString(widget.data?.nmProduk);
    textController[3].text = formatMoney(widget.data?.hargaBeli);
    textController[4].text = formatMoney(widget.data?.jumlah);
  }

  @override
  void initState() {
    super.initState();
    onInitState();
  }

  @override
  Widget build(BuildContext context) {
    ReturController controller = widget.controller;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
        color: neutralWhite,
      ),
      child: Form(
        key: tambahReturKey,
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
            Row(
              children: [
                Expanded(
                  child: SearchForm(
                    label: "ID Pembelian",
                    enabled: widget.isDetail == true ? false : true,
                    textEditingController: textController[0],
                    items: (search) => getSuggestions(
                      search,
                      resultPembelian.data?.dataPembelian,
                    ),
                    itemBuilder: (context, dataPembelian) {
                      return ListTile(
                        title: Text(trimString(dataPembelian.idPembelian ?? "")),
                      );
                    },
                    onChanged: (value) {
                      controller.dataPayloadRetur.idPembelian = trimString(value);
                      var data = resultPembelian.data?.dataPembelian
                          ?.firstWhere((element) => element.idPembelian == trimString(value));
                      controller.dataPayloadRetur.idSupplier = trimString(data?.idSupplier);
                      controller.dataPayloadRetur.nmSupplier = trimString(data?.nmSupplier);
                      controller.dataDetailSup = DataDetailSupplier(
                        idSupplier: trimString(data?.idSupplier),
                        nmSupplier: trimString(data?.nmSupplier),
                      );
                      controller.update();
                    },
                    onSelected: (data) {
                      controller.dataPayloadRetur.idPembelian = trimString(data.idPembelian);
                      controller.dataPayloadRetur.idSupplier = trimString(data.idSupplier);
                      controller.dataPayloadRetur.nmSupplier = trimString(data.nmSupplier);
                      controller.dataDetailSup = DataDetailSupplier(
                        idSupplier: trimString(data.idSupplier),
                        nmSupplier: trimString(data.nmSupplier),
                      );
                      controller.update();
                      textController[0].text = trimString(data.idPembelian);
                      cariDetailPembelian(trimString(data.idPembelian));
                      textController[1].clear();
                      textController[2].clear();
                      textController[3].clear();
                      textController[4].clear();
                      update();
                    },
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: SearchForm(
                    label: "ID Product",
                    enabled: widget.isDetail == true
                        ? false
                        : detailPembelian.data?.detailPurchase!.isEmpty ?? true
                            ? false
                            : true,
                    textEditingController: textController[1],
                    items: (search) => getDetailSuggestions(
                      search,
                      detailPembelian.data?.detailPurchase,
                    ),
                    itemBuilder: (context, dataPembelian) {
                      return ListTile(
                        title: Text(
                            "${trimString(dataPembelian.idProduct)} - ${trimString(dataPembelian.nmProduk)}"),
                      );
                    },
                    onSelected: (data) {
                      selectedDetailPembelian = data;
                      textController[1].text = trimString(data.idProduct);
                      textController[2].text = trimString(data.nmProduk);
                      textController[3].text = formatMoney(data.hargaBeli);
                      textController[4].text = trimString("0");
                      update();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: BaseForm(
                    label: "Nama Produk",
                    textEditingController: textController[2],
                    enabled: false,
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BaseForm(
                    label: "Harga Beli",
                    prefix: const BasePrefixRupiah(),
                    textInputFormater: [
                      ThousandsFormatter(),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    textEditingController: textController[3],
                    enabled: false,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: BaseForm(
                    label: "Jumlah",
                    enabled: widget.isDetail == true ? false : true,
                    textEditingController: textController[4],
                    onChanged: (value) {},
                    validator: Validatorless.multiple([
                      Validatorless.required("Data Wajib Diisi"),
                      Validatorless.numbersBetweenInterval(
                          1,
                          selectedDetailPembelian.jumlah?.toDouble() ?? 1,
                          "Jumlah Retur melebihi jumlah yang dibeli")
                    ]),
                    textInputFormater: [
                      ThousandsFormatter(),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Container(),
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
                    onPressed: () {
                      Get.back();
                    },
                    text: "Batal",
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: BasePrimaryButton(
                    onPressed: () async {
                      if (tambahReturKey.currentState!.validate()) {
                        if (widget.index != null) {
                          var totalNilaiBeli = (double.parse(removeComma(textController[3].text)) *
                                  double.parse(removeComma(textController[4].text)))
                              .round();
                          DetailsReturPayload data = DetailsReturPayload(
                            idProduct: textController[1].text,
                            nmProduk: textController[2].text,
                            hargaBeli: removeComma(textController[3].text),
                            nmDivisi: selectedDetailPembelian.nmDivisi,
                            jumlah: removeComma(textController[4].text),
                            totalNilaiBeli: totalNilaiBeli.toString(),
                          );
                          controller.dataPayloadRetur.details?[widget.index!] = data;
                        } else {
                          var totalNilaiBeli =
                              (double.parse(selectedDetailPembelian.hargaBeli ?? "0") *
                                      double.parse(textController[4].text))
                                  .round();
                          controller.dataPayloadRetur.details ??= [];

                          DetailsReturPayload data = DetailsReturPayload(
                            hargaBeli: selectedDetailPembelian.hargaBeli,
                            idProduct: selectedDetailPembelian.idProduct,
                            nmDivisi: selectedDetailPembelian.nmDivisi,
                            nmProduk: selectedDetailPembelian.nmProduk,
                            jumlah: textController[4].text,
                            totalNilaiBeli: totalNilaiBeli.toString(),
                          );
                          controller.dataPayloadRetur.details?.add(data);
                        }
                        controller.update();
                        update();
                        Navigator.pop(context);
                        // Get.back();
                      }
                    },
                    text: "Simpan",
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
