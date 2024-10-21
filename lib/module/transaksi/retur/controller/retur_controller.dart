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

  ReturPayloadModel dataPayloadRetur = ReturPayloadModel(details: []);
  DataDetailSupplier dataDetailSup = DataDetailSupplier();

  List<TextEditingController> textControllerRetur = [
    TextEditingController(),
    TextEditingController(),
  ];

  double totalHargaBeli = 0;
  double jumlah = 0;

  sumTotalHargaBeli() {
    totalHargaBeli = 0;
    for (var i = 0; i < (dataPayloadRetur.details?.length ?? 0); i++) {
      totalHargaBeli +=
          double.parse(dataPayloadRetur.details?[i].totalNilaiBeli ?? "0");
    }
    dataPayloadRetur.totalNilaiBeli = totalHargaBeli.toString();
  }

  sumJumlah() {
    jumlah = 0;
    for (var i = 0; i < (dataPayloadRetur.details?.length ?? 0); i++) {
      jumlah += int.parse(dataPayloadRetur.details?[i].jumlah ?? "0");
    }
    dataPayloadRetur.jumlah = jumlah.toString();
  }

  postCreateRetur() async {
    Get.back();

    showCircleDialogLoading();
    try {
      var payload = dataPayloadRetur.toJson();

      if (trimString(payload['keterangan']).toString().isEmpty) {
        payload.removeWhere(
          (key, value) => key == "keterangan",
        );
      }

      ReturResult result = await ApiService.createRetur(
        data: payload,
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        await showDialogBase(
          content: const DialogBerhasil(),
        );

        router.push("/transaksi/retur");
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

  postRemoveRetur(String idRetur) async {
    Get.back();
    showCircleDialogLoading();
    try {
      ReturResult result = await ApiService.removeRetur(
        data: {"id_retur": idRetur},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataRetur();
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

  postDetailPurchase(String idRetur) async {
    showCircleDialogLoading();
    try {
      DetailReturResult result = await ApiService.detailRetur(
        data: {"id_retur": idRetur},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        isList = false;
        isDetail = true;
        dataPayloadRetur = dataPayloadRetur.copyWith(
          details: result.data,
        );

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
    dataFuture = cariDataRetur();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
