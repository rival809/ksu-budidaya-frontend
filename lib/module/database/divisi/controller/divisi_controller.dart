import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class DivisiController extends State<DivisiView> {
  static late DivisiController instance;
  late DivisiView view;

  String page = "1";
  String size = "10";
  TextEditingController divisiNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  DataListRole dataListRole = DataListRole();
  ListRoleResult result = ListRoleResult();

  List<String> listRoleView = [
    "id_divisi",
    "nama_divisi",
  ];

  cariDataUser() async {
    try {
      result = ListRoleResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(divisiNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"role_name": trimString(divisiNameController.text)});
      }

      // result = await ApiService.listRole(
      //   data: dataCari,
      // ).timeout(const Duration(seconds: 30));

      result = ListRoleResult(
        data: DataListRole(
          dataRoles: [
            {
              "id_divisi": "Divisi001",
              "nama_divisi": "ADMIN",
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
