import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class AnggotaController extends State<AnggotaView> {
  static late AnggotaController instance;
  late AnggotaView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController anggotaNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  DataAnggota dataListAnggota = DataAnggota();
  AnggotaResult result = AnggotaResult();

  List<String> listRoleView = [
    "id_anggota",
    "nm_anggota",
    "alamat",
    "no_wa",
    "limit_pinjaman",
    "hutang",
  ];

  cariDataAnggota({bool? isAsc, String? field}) async {
    try {
      result = AnggotaResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(anggotaNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"nm_anggota": trimString(anggotaNameController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      result = await ApiService.listAnggota(
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

  postCreateAnggota(DataMap dataCreate) async {
    Get.back();

    showCircleDialogLoading();
    try {
      AnggotaResult result = await ApiService.createAnggota(
        data: dataCreate,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataAnggota();
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

  postRemoveAnggota(String idAnggota) async {
    Get.back();
    showCircleDialogLoading();
    try {
      AnggotaResult result = await ApiService.removeAnggota(
        data: {"id_anggota": idAnggota},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataAnggota();
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

  postUpdateAnggota(DataMap dataEdit) async {
    Get.back();

    showCircleDialogLoading();
    try {
      AnggotaResult result = await ApiService.updateAnggota(
        data: dataEdit,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataAnggota();
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
  void initState() {
    instance = this;
    dataFuture = cariDataAnggota();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
