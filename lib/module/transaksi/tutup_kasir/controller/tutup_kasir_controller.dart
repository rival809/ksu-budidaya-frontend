import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class TutupKasirController extends State<TutupKasirView> {
  static late TutupKasirController instance;
  late TutupKasirView view;

  String page = "1";
  String size = "500";
  bool isAsc = true;
  TextEditingController penjualanNameController = TextEditingController();
  Future<dynamic>? dataFuture;
  ListTutupKasirResult result = ListTutupKasirResult();
  DataTutupKasir dataListTutupKasir = DataTutupKasir();

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

  String? field;

  cariDataTutupKasir({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = ListTutupKasirResult();
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
      }

      if (field != null) {
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      if (field == null) {
        dataCari.removeWhere((key, value) => key == "sort_order");
        dataCari.removeWhere((key, value) => key == "sort_by");
        dataCari.addAll({
          "sort_order": ["desc"]
        });
        dataCari.addAll({
          "sort_by": ["created_at"]
        });
      }

      result = await ApiService.listTutupKasir(
        data: dataCari,
      ).timeout(const Duration(seconds: 30));

      return result;
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  TotalPenjualanResult dataPenjualan = TotalPenjualanResult();

  cariDataTotalPenjualan() async {
    try {
      showCircleDialogLoading();
      dataPenjualan = TotalPenjualanResult();

      dataPenjualan = await ApiService.totalPenjualan(
        data: {
          "tg_tutup_kasir": formatDateTime(DateTime.now().toString()),
        },
      ).timeout(const Duration(seconds: 30));
      Get.back();
      if (dataPenjualan.success == true) {
        DetailDataTutupKasir data = DetailDataTutupKasir();
        data.qris = trimString(dataPenjualan.data?.penjualan?.penjualanQris.toString());
        data.kredit = trimString(dataPenjualan.data?.penjualan?.penjualanKredit.toString());
        data.tunai = trimString(dataPenjualan.data?.penjualan?.penjualanTunai.toString());
        data.totalNilaiBeli = trimString(dataPenjualan.data?.keuntungan?.totalNilaiBeli.toString());
        data.totalNilaiJual = trimString(dataPenjualan.data?.keuntungan?.totalNilaiJual.toString());
        data.totalKeuntungan =
            trimString(dataPenjualan.data?.keuntungan?.totalKeuntungan.toString());
        data.total = trimString(dataPenjualan.data?.penjualan?.totalPenjualan.toString());
        data.shift = dataPenjualan.data?.keterangan?.contains("siang") ?? false ? "SIANG" : "PAGI";
        data.namaKasir = trimString(
          UserDatabase.userDatabase.data?.userData?.username,
        );
        data.username = trimString(
          UserDatabase.userDatabase.data?.userData?.username,
        );
        data.tgTutupKasir = formatDateTime(DateTime.now().toString());
        showDialogBase(
          width: 700,
          content: DialogTutupKasir(
            detail: data,
            isEdit: null,
          ),
        );
      }
    } catch (e) {
      Get.back();

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  postRemoveTutupKasir(String idTutupKasir) async {
    try {
      Get.back();
      showCircleDialogLoading();
      TutupKasirResult result = await ApiService.removeTutupKasir(
        data: {"id_tutup_kasir": idTutupKasir},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        await showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataTutupKasir();
        update();
      }
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  postRefreshTutupKasir(String idTutupKasir) async {
    try {
      Get.back();
      showCircleDialogLoading();
      TutupKasirResult result = await ApiService.refreshTutupKasir(
        data: {"id_tutup_kasir": idTutupKasir},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        await showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataTutupKasir();
        update();
      }
    } catch (e) {
      Navigator.pop(context);

      if (e.toString().contains("TimeoutException")) {
        showInfoDialog("Tidak Mendapat Respon Dari Server! Silakan coba lagi.", context);
      } else {
        showInfoDialog(e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  @override
  void initState() {
    instance = this;
    dataFuture = cariDataTutupKasir();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
