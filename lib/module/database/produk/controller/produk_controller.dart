import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class ProdukController extends State<ProdukView> {
  static late ProdukController instance;
  late ProdukView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController productNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  DataProduct dataProduct = DataProduct();
  ProductResult result = ProductResult();

  List<String> listProdukView = [
    "id_divisi",
    "id_product",
    "nm_product",
    "id_supplier",
    "harga_beli",
    "harga_jual",
    "jumlah",
    "total_beli",
    "total_jual",
  ];

  PlutoColumnType typeField(String field) {
    switch (field) {
      case "jumlah":
        return PlutoColumnType.number(locale: "id");
      case "harga_beli":
        return PlutoColumnType.number(locale: "id");
      case "harga_jual":
        return PlutoColumnType.number(locale: "id");
      case "total_jual":
        return PlutoColumnType.number(locale: "id");
      case "total_beli":
        return PlutoColumnType.number(locale: "id");

      default:
        return PlutoColumnType.text();
    }
  }

  List<dynamic> listData = [];

  bool step1 = true;
  bool step2 = false;

  onSwitchStep(String valueStep) {
    switch (valueStep) {
      case "1":
        step1 = true;
        step2 = false;
        update();
        break;
      case "2":
        step1 = false;
        step2 = true;
        update();
        break;

      default:
        step1 = true;
        step2 = false;
        update();
    }
    update();
  }

  cariDataProduct({bool? isAsc, String? field}) async {
    try {
      result = ProductResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(productNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"role_name": trimString(productNameController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      result = await ApiService.listProduct(
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

  postCreateProduct(DataMap dataCreate) async {
    Get.back();

    showCircleDialogLoading(context);
    try {
      ProductResult result = await ApiService.createProduct(
        data: dataCreate,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataProduct();
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

  postRemoveProduct(String idProduct) async {
    Get.back();
    showCircleDialogLoading(context);
    try {
      SupplierResult result = await ApiService.removeSupplier(
        data: {"id_product": idProduct},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataProduct();
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

  postUpdateProduct(DataMap dataEdit) async {
    Get.back();

    showCircleDialogLoading(context);
    try {
      ProductResult result = await ApiService.updateProduct(
        data: dataEdit,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataProduct();
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
    dataFuture = cariDataProduct();

    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
