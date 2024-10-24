import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class BayarHutangAnggotaController extends State<BayarHutangAnggotaView> {
  static late BayarHutangAnggotaController instance;
  late BayarHutangAnggotaView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController hutangNameController = TextEditingController();

  bool step1 = true;
  bool step2 = false;
  Future<dynamic>? dataFuture;
  Future<dynamic>? dataFutureHistory;

  onSwitchStep(String valueStep) {
    switch (valueStep) {
      case "1":
        step1 = true;
        step2 = false;
        update();
        dataFuture = cariDataHutangAnggota();

        break;
      case "2":
        step1 = false;
        step2 = true;
        update();
        dataFutureHistory = cariDataHistoryHutangDagang();
        break;

      default:
        step1 = true;
        step2 = false;
        update();
        dataFuture = cariDataHutangAnggota();
    }
    update();
  }

  DataHutangAnggota dataHutangAnggota = DataHutangAnggota();
  DataHistoryHutangDagang dataHistoryHutangDagang = DataHistoryHutangDagang();
  HutangAnggotaResult result = HutangAnggotaResult();
  HistoryHutangDagangResult resultHistory = HistoryHutangDagangResult();
  List<String> listHutangAnggotaView = [
    "id_penjualan",
    "tg_hutang",
    "nm_anggota",
    "nominal",
  ];
  List<String> listHistoryHutangDagangView = [
    "id_pembelian",
    "tg_bayar_hutang",
    "nm_supplier",
    "nominal",
    "keterangan",
  ];

  cariDataHutangAnggota({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = HutangAnggotaResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(hutangNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"id_anggota": trimString(hutangNameController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      result = await ApiService.listHutangAnggota(
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

  cariDataHistoryHutangDagang({
    bool? isAsc,
    String? field,
  }) async {
    try {
      resultHistory = HistoryHutangDagangResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      resultHistory = await ApiService.listHistoryHutangDagang(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));

      return resultHistory;
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
    dataFuture = cariDataHutangAnggota();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
