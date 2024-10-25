import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class BayarHutangAnggotaController extends State<BayarHutangAnggotaView> {
  static late BayarHutangAnggotaController instance;
  late BayarHutangAnggotaView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController hutangNameController = TextEditingController();

  Future<dynamic>? dataFuture;
  Future<dynamic>? dataFutureHistory;

  bool step1 = true;
  bool step2 = false;
  bool step3 = false;

  onSwitchStep(String valueStep) {
    switch (valueStep) {
      case "1":
        step1 = true;
        step2 = false;
        step3 = false;
        update();
        dataFuture = cariDetailAnggota();

        break;
      case "2":
        step1 = false;
        step2 = true;
        step3 = false;
        update();
        dataFuture = cariDataPenjualan();
        break;
      case "3":
        step1 = false;
        step2 = false;
        step3 = true;
        update();
        dataFuture = cariDataHutangAnggota();
        break;

      default:
        step1 = true;
        step2 = false;
        step3 = false;
        update();
        dataFuture = cariDetailAnggota();
    }
    update();
  }

  DetailAnggotaResult detailAnggota = DetailAnggotaResult();
  PenjualanResult transaksiAnggota = PenjualanResult();
  DataHutangAnggota dataHutangAnggota = DataHutangAnggota();
  DataHistoryHutangDagang dataHistoryHutangDagang = DataHistoryHutangDagang();
  HutangAnggotaResult result = HutangAnggotaResult();
  HistoryHutangDagangResult resultHistory = HistoryHutangDagangResult();
  DataPenjualan dataListPenjualan = DataPenjualan();
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

  cariDetailAnggota() async {
    try {
      detailAnggota = DetailAnggotaResult();
      detailAnggota = await ApiService.detailAnggota(
        idAnggota: widget.idAnggota,
      ).timeout(const Duration(seconds: 30));

      return detailAnggota;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  cariDataPenjualan({
    bool? isAsc,
    String? field,
  }) async {
    try {
      transaksiAnggota = PenjualanResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      // dataCari.addAll({"id_anggota": trimString(widget.idAnggota)});

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      transaksiAnggota = await ApiService.listPenjualan(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));

      return transaksiAnggota;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog(
            "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

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

      dataCari.addAll({"id_anggota": trimString(widget.idAnggota)});

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

  // cariDataHistoryHutangDagang({
  //   bool? isAsc,
  //   String? field,
  // }) async {
  //   try {
  //     resultHistory = HistoryHutangDagangResult();
  //     DataMap dataCari = {
  //       "page": page,
  //       "size": size,
  //     };

  //     if (isAsc != null) {
  //       dataCari.addAll({
  //         "sort_order": [isAsc == true ? "asc" : "desc"]
  //       });
  //       dataCari.addAll({
  //         "sort_by": [field]
  //       });
  //     }

  //     resultHistory = await ApiService.listHistoryHutangDagang(
  //       data: dataCari,
  //     ).timeout(const Duration(seconds: 30));

  //     return resultHistory;
  //   } catch (e) {
  //     if (e.toString().contains("TimeoutException")) {
  //       showInfoDialog(
  //           "Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
  //     } else {
  //       showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
  //     }
  //   }
  // }

  @override
  void initState() {
    instance = this;
    dataFuture = cariDetailAnggota();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
