import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import '../view/manajemen_user_view.dart';

class ManajemenUserController extends State<ManajemenUserView> {
  static late ManajemenUserController instance;
  late ManajemenUserView view;

  String page = "1";
  String size = "10";
  TextEditingController roleNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  DataListRole dataListRole = DataListRole();
  ListRoleResult result = ListRoleResult();

  List<String> listRoleView = [
    "nama",
    "username",
    "role",
  ];

  cariDataUser() async {
    try {
      result = ListRoleResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(roleNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"role_name": trimString(roleNameController.text)});
      }

      // result = await ApiService.listRole(
      //   data: dataCari,
      // ).timeout(const Duration(seconds: 30));

      result = ListRoleResult(
        data: DataListRole(
          dataRoles: [
            {"nama": "ROLE001", "username": "ADMIN", "role": "ADMIN"},
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
