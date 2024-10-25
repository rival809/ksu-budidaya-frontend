import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class TutupKasirController extends State<TutupKasirView> {
  static late TutupKasirController instance;
  late TutupKasirView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController penjualanNameController = TextEditingController();
  Future<dynamic>? dataFuture;
  PenjualanResult result = PenjualanResult();
  DataPenjualan dataListPenjualan = DataPenjualan();

  List<String> listTutupKasir = [
    "tg_tutup_kasir",
    "shift",
    "nama_kasir",
    "total_nilai_beli",
    "total_nilai_jual",
    "total_keuntungan",
    "tunai",
    "qris",
    "kredit",
    "total",
    "uang_tunai",
  ];

  cariDataTutupKasir({
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
        dataCari.addAll({"username": trimString(penjualanNameController.text)});
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

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
