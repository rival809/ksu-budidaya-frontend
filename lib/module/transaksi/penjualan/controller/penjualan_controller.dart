import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class PenjualanController extends State<PenjualanView> {
  static late PenjualanController instance;
  late PenjualanView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController penjualanNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  bool isList = true;
  bool isDetail = false;

  DataPenjualan dataListPenjualan = DataPenjualan();
  PenjualanResult result = PenjualanResult();
  List<String> listPenjualanView = [
    "id_penjualan",
    "tg_penjualan",
    "jumlah",
    "total_nilai_beli",
    "total_nilai_jual",
    "nm_anggota",
    "jenis_pembayaran",
    "keterangan",
    "username",
  ];

  cariDataPenjualan({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = PenjualanResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(penjualanNameController.text).toString().isNotEmpty) {
        dataCari
            .addAll({"keterangan": trimString(penjualanNameController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      result = await ApiService.listPenjualan(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));

      return result;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  postRemoveSale(String id_penjualan) async {
    Get.back();
    showCircleDialogLoading();
    try {
      PenjualanResult result = await ApiService.removePenjualan(
        data: {"id_penjualan": id_penjualan},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataPenjualan();
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

  // postDetailPurchase(String id_pembelian) async {
  //   showCircleDialogLoading();
  //   try {
  //     DetailPembelianResult result = await ApiService.detailPembelian(
  //       data: {"id_pembelian": id_pembelian},
  //     ).timeout(const Duration(seconds: 30));

  //     Navigator.pop(context);

  //     if (result.success == true) {
  //       isList = false;
  //       isDetail = true;
  //       dataPenjualan = dataPenjualan.copyWith(
  //         details: result.data,
  //       );

  //       if (result.data?.isNotEmpty ?? false) {
  //         isPpn = result.data!.any((element) => element.ppn != "0");
  //       }

  //       update();
  //     }
  //   } catch (e) {
  //     Navigator.pop(context);

  //     if (e.toString().contains("TimeoutException")) {
  //       showInfoDialog(
  //           "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
  //     } else {
  //       showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
  //     }
  //   }
  // }

  postCreatePembelian() async {
    Get.back();

    showCircleDialogLoading();
    try {
      var payload = dataPenjualan.toJson();

      for (var i = 0; i < payload['details'].length; i++) {
        payload['details'][i].removeWhere(
          (key, value) => key == "id_detail_pembelian",
        );
        payload['details'][i].removeWhere(
          (key, value) => key == "created_at",
        );
        payload['details'][i].removeWhere(
          (key, value) => key == "updated_at",
        );
        payload['details'][i].removeWhere(
          (key, value) => key == "id_pembelian",
        );
      }

      if (trimString(payload['keterangan']).toString().isEmpty) {
        payload.removeWhere(
          (key, value) => key == "keterangan",
        );
      }

      payload.update("tg_pembelian", (value) => formatDate(value.toString()));

      PembelianResult result = await ApiService.createPembelian(
        data: payload,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        await showDialogBase(
          content: const DialogBerhasil(),
        );

        router.push("/transaksi/pembelian");
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

  TextEditingController cariProdukController = TextEditingController();
  CreatePenjualanModel dataPenjualan = CreatePenjualanModel();

  double bayar = 0;
  double kembali = 0;

  sumTotal() {
    double total = 0;
    for (int i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      total += (double.parse(dataPenjualan.details?[i].harga ?? "0") *
              double.parse(dataPenjualan.details?[i].jumlah ?? "0")) -
          (double.parse(dataPenjualan.details?[i].harga ?? "0") *
                  double.parse(dataPenjualan.details?[i].jumlah ?? "0")) *
              (double.parse(dataPenjualan.details?[i].diskon ?? "0") / 100);
    }

    dataPenjualan.totalNilaiJual = total.toString();
  }

  Timer? _debounce;
  void onProdctSearch(String value) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(
      const Duration(seconds: 1),
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
        dataPenjualan.details?.add(
          DetailsCreatePenjualan(
            idProduct: trimString(result.data?.idProduct),
            harga: trimString(result.data?.hargaJual),
            jumlah: "1",
            nmProduk: trimString(result.data?.nmProduct),
            nmDivisi:
                getNamaDivisi(idDivisi: trimString(result.data?.idDivisi)),
            diskon: "0",
            total: (double.parse(result.data?.hargaJual ?? "0") *
                    double.parse("1"))
                .toString(),
          ),
        );

        cariProdukController.clear();

        update();
      }
    } catch (e) {
      Navigator.pop(context);
    }
  }

  List<TextEditingController> textControllerDetail = [
    TextEditingController(),
    TextEditingController(),
  ];

  bool isLoading = false;
  bool isPpn = false;
  bool isDiskon = false;
  double totalHargaBeli = 0;
  double totalHargaJual = 0;
  double totalPpn = 0;
  double totalDiskon = 0;
  double jumlah = 0;

  double rowHeight = 47;
  double heighFooter = 49;

  double getRowHeigh() {
    if (isPpn) {
      return heighFooter = 123;
    } else {
      return heighFooter = 86;
    }
  }

  sumTotalDiskon() {
    totalDiskon = 0;
    for (var i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      totalDiskon += double.parse(dataPenjualan.details?[i].diskon ?? "0");
    }
  }

  sumTotalNilaiBeli() {
    totalHargaBeli = 0;
    for (var i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      totalHargaBeli += double.parse(dataPenjualan.details?[i].total ?? "0");
    }
    totalHargaBeli = totalHargaBeli + totalPpn;
    dataPenjualan.totalNilaiBeli = totalHargaBeli.toString();
  }

  sumTotalNilaiJual() {
    totalHargaJual = 0;
    for (var i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      totalHargaJual += double.parse(dataPenjualan.details?[i].total ?? "0");
    }
    dataPenjualan.totalNilaiJual = totalHargaJual.toString();
  }

  sumJumlah() {
    jumlah = 0;
    for (var i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      jumlah += int.tryParse(dataPenjualan.details?[i].jumlah ?? "0") ?? 0;
    }
    dataPenjualan.jumlah = jumlah.toString();
  }

  @override
  void initState() {
    instance = this;
    GlobalReference().supplierReference();
    dataFuture = cariDataPenjualan();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
