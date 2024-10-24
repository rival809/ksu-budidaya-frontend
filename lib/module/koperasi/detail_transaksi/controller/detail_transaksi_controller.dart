import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DetailTransaksiController extends State<DetailTransaksiView> {
  static late DetailTransaksiController instance;
  late DetailTransaksiView view;

  CreatePenjualanModel dataPenjualan = CreatePenjualanModel();

  String? totalBayar = "0";
  int totalKembali = 0;

  sumTotal() {
    double totalNilaiJual = 0;
    double totalNilaiBeli = 0;
    double jumlah = 0;
    for (int i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      totalNilaiJual += ((double.parse(dataPenjualan.details?[i].harga ?? "0") -
              double.parse(dataPenjualan.details?[i].diskon ?? "0")) *
          double.parse(dataPenjualan.details?[i].jumlah ?? "0"));
      totalNilaiBeli +=
          (double.parse(dataPenjualan.details?[i].hargaBeli ?? "0") *
              double.parse(dataPenjualan.details?[i].jumlah ?? "0"));
      jumlah += double.parse(dataPenjualan.details?[i].jumlah ?? "0");
    }

    dataPenjualan.totalNilaiJual = totalNilaiJual.toString();
    dataPenjualan.totalNilaiBeli = totalNilaiBeli.toString();
    dataPenjualan.jumlah = jumlah.toString();
  }

  sumTotalIndex() {
    double total = 0;
    for (int i = 0; i < (dataPenjualan.details?.length ?? 0); i++) {
      var diskon = double.parse(
        removeComma(dataPenjualan.details?[i].diskon ?? "0"),
      );

      var hargaJual = double.parse(
        removeComma(dataPenjualan.details?[i].harga ?? "0"),
      );

      var jumlah = double.parse(
        removeComma(dataPenjualan.details?[i].jumlah ?? "0"),
      );

      var totalHarga = ((hargaJual - diskon) * jumlah).toString();
      dataPenjualan.details?[i].total = totalHarga;
    }
  }

  PenjualanResult result = PenjualanResult();

  List<TextEditingController> textControllerDialog = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  postDetailPenjualan(String idPenjualan) async {
    try {
      DetailPenjualanResult result = await ApiService.detailPenjualan(
        data: {"id_penjualan": idPenjualan},
      ).timeout(const Duration(seconds: 30));

      if (result.success == true) {
        dataPenjualan = dataPenjualan.copyWith(
          details: result.details,
        );

        update();
      }
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  cariDataPenjualan() async {
    try {
      result = PenjualanResult();
      DataMap dataCari = {};

      result = await ApiService.listPenjualan(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  @override
  void initState() {
    instance = this;
    super.initState();
    GlobalReference().supplierReference();
    GlobalReference().anggotaReference();
    cariDataPenjualan();
    postDetailPenjualan(trimString(widget.idPenjualan));
    textControllerDialog[2].text = "0";
    totalBayar = "0";
    textControllerDialog[3].text = "0";
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
