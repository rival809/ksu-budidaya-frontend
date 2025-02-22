import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class SupplierController extends State<SupplierView> {
  static late SupplierController instance;
  late SupplierView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController supplierNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  DataSupplier dataSupplier = DataSupplier();
  SupplierResult result = SupplierResult();

  List<String> listRoleView = [
    "id_supplier",
    "nm_supplier",
    "nm_pemilik",
    "nm_pic",
    "no_wa",
    "alamat",
    "hutang_dagang",
  ];

  cariDataSupplier({bool? isAsc, String? field}) async {
    try {
      result = SupplierResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(supplierNameController.text).toString().isNotEmpty) {
        dataCari.addAll(
          {
            "nm_supplier": trimString(supplierNameController.text),
          },
        );
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

      result = await ApiService.listSupplier(
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

  postCreateSupplier(DataMap dataCreate) async {
    Get.back();

    showCircleDialogLoading();
    try {
      SupplierResult result = await ApiService.createSupplier(
        data: dataCreate,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        GlobalReference().supplierReference();
        dataFuture = cariDataSupplier();
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

  postRemoveSupplier(String idSupplier) async {
    Get.back();
    showCircleDialogLoading();
    try {
      SupplierResult result = await ApiService.removeSupplier(
        data: {"id_supplier": idSupplier},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        GlobalReference().supplierReference();
        dataFuture = cariDataSupplier();
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

  postUpdateSupplier(DataMap dataEdit) async {
    Get.back();

    showCircleDialogLoading();
    try {
      SupplierResult result = await ApiService.updateSupplier(
        data: dataEdit,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        GlobalReference().supplierReference();
        dataFuture = cariDataSupplier();
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
    dataFuture = cariDataSupplier();

    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
