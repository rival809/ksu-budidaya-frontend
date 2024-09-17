import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ManajemenRoleController extends State<ManajemenRoleView> {
  static late ManajemenRoleController instance;
  late ManajemenRoleView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController roleNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  DataListRole dataListRole = DataListRole();
  ListRoleResult result = ListRoleResult();

  List<String> listRoleView = [
    "id_role",
    "role_name",
  ];

  cariDataRole({bool? isAsc, String? field}) async {
    try {
      result = ListRoleResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(roleNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"role_name": trimString(roleNameController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      result = await ApiService.listRole(
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

  postCreateRole(DataRoles dataEdit) async {
    showCircleDialogLoading(context);
    try {
      DataMap data = dataEdit.toJson();
      data.removeWhere((key, value) => key == "id_role");
      data.removeWhere((key, value) => key == "updated_at");
      data.removeWhere((key, value) => key == "created_at");

      CreateRoleResult result = await ApiService.createRole(
        data: data,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          context: context,
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataRole();
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

  postRemoveRole(String idRole) async {
    showCircleDialogLoading(context);
    try {
      CreateRoleResult result = await ApiService.removeRole(
        data: {
          "id_role": idRole,
        },
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          context: context,
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataRole();
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

  postUpdateRole(DataMap dataEdit, String idRole) async {
    showCircleDialogLoading(context);
    try {
      dataEdit.addAll({"id_role": idRole});

      CreateRoleResult result = await ApiService.updateRole(
        data: dataEdit,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          context: context,
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataRole();
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
    dataFuture = cariDataRole();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
