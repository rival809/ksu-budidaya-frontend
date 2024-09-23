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
        dataCari.addAll({"role_name": trimString(supplierNameController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
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
    dataFuture = cariDataSupplier();

    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
