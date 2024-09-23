import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DivisiController extends State<DivisiView> {
  static late DivisiController instance;
  late DivisiView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController divisiNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  DataDivisi dataDivisi = DataDivisi();
  DivisiResult result = DivisiResult();

  List<String> listRoleView = [
    "id_divisi",
    "nm_divisi",
  ];

  cariDataDivisi({bool? isAsc, String? field}) async {
    try {
      result = DivisiResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(divisiNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"nm_divisi": trimString(divisiNameController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      result = await ApiService.listDivisi(
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

  postCreateDivisi(String namaDivisi) async {
    Get.back();

    showCircleDialogLoading(context);
    try {
      DivisiResult result = await ApiService.createDivisi(
        nmDivisi: namaDivisi,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataDivisi();
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

  postUpdateDivisi(String idDivisi, String nmDivisi) async {
    Get.back();

    showCircleDialogLoading(context);
    try {
      DivisiResult result = await ApiService.updateDivisi(
        idDivisi: idDivisi,
        nmDivisi: nmDivisi,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataDivisi();
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

  postRemoveDivisi(String idDivisi) async {
    Get.back();
    showCircleDialogLoading(context);
    try {
      DivisiResult result = await ApiService.removeDivisi(
        data: {"id_divisi": idDivisi},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataDivisi();
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
    dataFuture = cariDataDivisi();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
