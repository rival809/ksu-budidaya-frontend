import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';

class ReturController extends State<ReturView> {
  static late ReturController instance;
  late ReturView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController returSearchController = TextEditingController();

  Future<dynamic>? dataFuture;

  bool isList = true;
  bool isDetail = false;

  DataRetur dataRetur = DataRetur();
  ReturResult result = ReturResult();

  List<String> listReturView = [
    "id_retur",
    "tg_retur",
    "nm_supplier",
    "jumlah",
    "total_nilai_beli",
    "keterangan",
  ];

  cariDataRetur({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = ReturResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(returSearchController.text).toString().isNotEmpty) {
        dataCari.addAll({"keterangan": trimString(returSearchController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      result = await ApiService.listRetur(
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

  ReturPayloadModel dataPayloadRetur = ReturPayloadModel();

  List<TextEditingController> textControllerRetur = [
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void initState() {
    instance = this;
    dataFuture = cariDataRetur();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
