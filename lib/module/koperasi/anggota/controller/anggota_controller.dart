import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class AnggotaController extends State<AnggotaView> {
  static late AnggotaController instance;
  late AnggotaView view;

  String page = "1";
  String size = "10";
  TextEditingController anggotaNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  DataListRole dataListRole = DataListRole();
  ListRoleResult result = ListRoleResult();

  List<String> listRoleView = [
    "id",
    "nama",
    "alamat",
    "no_whatsapp",
    "limit",
    "hutang",
  ];

  cariDataUser() async {
    try {
      result = ListRoleResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(anggotaNameController.text).toString().isNotEmpty) {
        dataCari.addAll({"role_name": trimString(anggotaNameController.text)});
      }

      // result = await ApiService.listRole(
      //   data: dataCari,
      // ).timeout(const Duration(seconds: 30));

      result = ListRoleResult(
        data: DataListRole(
            // dataRoles: [
            //   {
            //     "id": "Anggota001",
            //     "nama": "ADMIN",
            //     "alamat": "A",
            //     "no_whatsapp": "083391712",
            //     "limit": "300000",
            //     "hutang": "100000",
            //   },
            // ],
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
