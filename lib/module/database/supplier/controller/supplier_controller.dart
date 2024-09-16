import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class SupplierController extends State<SupplierView> {
  static late SupplierController instance;
  late SupplierView view;

  String page = "1";
  String size = "10";
  TextEditingController supplierNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  DataListRole dataListRole = DataListRole();
  ListRoleResult result = ListRoleResult();

  List<String> listRoleView = [
    "id",
    "nama_supplier",
    "alamat",
    "kontak",
    "pemilik",
    "hutang_dagang",
  ];

  cariDataUser() async {
    try {
      result = ListRoleResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(supplierNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"role_name": trimString(supplierNameController.text)});
      }

      // result = await ApiService.listRole(
      //   data: dataCari,
      // ).timeout(const Duration(seconds: 30));

      result = ListRoleResult(
        data: DataListRole(
          dataRoles: [
            {
              "id": "Supplier001",
              "nama_supplier": "ADMIN",
              "alamat": "A",
              "kontak": "B",
              "pemilik": "ADMIN",
              "hutang_dagang": "100000",
            },
          ],
        ),
      );

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
