import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ManajemenUserController extends State<ManajemenUserView> {
  static late ManajemenUserController instance;
  late ManajemenUserView view;

  String page = "1";
  String size = "500";
  bool isAsc = true;
  TextEditingController userNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  DataListUser dataListUser = DataListUser();
  ListUserResult result = ListUserResult();

  List<String> listRoleView = [
    "username",
    "name",
    "id_role",
  ];

  cariDataUser({bool? isAsc, String? field}) async {
    try {
      result = ListUserResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(userNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"username": trimString(userNameController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      result = await ApiService.listUser(
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

  postDetailUser({required String? username}) async {
    showCircleDialogLoading();
    try {
      DetailUserResult result = await ApiService.detailUser(
        data: {"username": username},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          width: 700,
          content: DialogUser(
            isDetail: true,
            data: result,
          ),
        );

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

  postCreateUser(DataMap dataCreate) async {
    Get.back();

    showCircleDialogLoading();
    try {
      DetailUserResult result = await ApiService.createUser(
        data: dataCreate,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        GlobalReference().userReference();
        dataFuture = cariDataUser();
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

  postRemoveUser(String username) async {
    Get.back();
    showCircleDialogLoading();
    try {
      DetailUserResult result = await ApiService.removeUser(
        data: {"username": username},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        GlobalReference().userReference();
        dataFuture = cariDataUser();
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

  postUpdateUser(DataMap dataEdit) async {
    Get.back();

    showCircleDialogLoading();
    try {
      DetailUserResult result = await ApiService.updateUser(
        data: dataEdit,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        GlobalReference().userReference();
        dataFuture = cariDataUser();
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
    dataFuture = cariDataUser();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
