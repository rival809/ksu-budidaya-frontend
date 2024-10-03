import 'package:flutter/material.dart';
import 'package:ksu_budidaya/core.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class PembelianController extends State<PembelianView> {
  static late PembelianController instance;
  late PembelianView view;

  String page = "1";
  String size = "10";
  bool isAsc = true;
  TextEditingController pembelianNameController = TextEditingController();

  Future<dynamic>? dataFuture;

  bool isList = true;
  bool isDetail = false;

  DataPembelian dataCashInOut = DataPembelian();
  PembelianResult result = PembelianResult();
  List<String> listRoleView = [
    "id_pembelian",
    "tg_pembelian",
    "id_supplier",
    "jumlah",
    "total_harga_beli",
    "total_harga_jual",
    "jenis_pembayaran",
    "keterangan",
  ];

  cariDataPembelian({
    bool? isAsc,
    String? field,
  }) async {
    try {
      result = PembelianResult();
      DataMap dataCari = {
        "page": page,
        "size": size,
      };

      if (trimString(pembelianNameController.text).toString().isNotEmpty) {
        dataCari
            .addAll({"keterangan": trimString(pembelianNameController.text)});
      }

      if (isAsc != null) {
        dataCari.addAll({
          "sort_order": [isAsc == true ? "asc" : "desc"]
        });
        dataCari.addAll({
          "sort_by": [field]
        });
      }

      result = await ApiService.listPembelian(
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

  postDetailPurchase(String id_pembelian) async {
    showCircleDialogLoading();
    try {
      DetailPembelianResult result = await ApiService.detailPembelian(
        data: {"id_pembelian": id_pembelian},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        isList = false;
        isDetail = true;
        dataPembelian = dataPembelian.copyWith(
          details: result.data,
        );

        if (result.data?.isNotEmpty ?? false) {
          isPpn = result.data!.any((element) => element.ppn != "0");
        }

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

  postRemovePurchase(String id_pembelian) async {
    Get.back();
    showCircleDialogLoading();
    try {
      PembelianResult result = await ApiService.removePembelian(
        data: {"id_pembelian": id_pembelian},
      ).timeout(const Duration(seconds: 30));

      Navigator.pop(context);

      if (result.success == true) {
        showDialogBase(
          content: const DialogBerhasil(),
        );

        dataFuture = cariDataPembelian();
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

  CreatePembelianModel dataPembelian = CreatePembelianModel();

  List<TextEditingController> textControllerDetail = [
    TextEditingController(),
    TextEditingController(),
  ];

  bool isLoading = false;
  bool isPpn = false;
  bool isDiskon = false;
  double totalHargaBeli = 0;
  double totalHargaJual = 0;
  double totalPpn = 0;
  double totalDiskon = 0;

  double rowHeight = 47;
  double heighFooter = 49;

  double getRowHeigh() {
    if (isPpn) {
      return heighFooter = 123;
    } else {
      return heighFooter = 86;
    }
  }

  checkPpn() {
    isPpn = false;

    if (dataPembelian.details?.isNotEmpty ?? false) {
      isPpn = dataPembelian.details!
          .every((element) => trimString(element.ppn ?? "0") != "0");
    }
  }

  checklistPpn(bool value) {
    isPpn = value;

    for (var detail in dataPembelian.details ?? [DataDetailPembelian()]) {
      if (value) {
        detail.ppn = ((11 / 100) *
                double.parse(detail.hargaBeli ?? "0") *
                double.parse(detail.jumlah?.toString() ?? "0"))
            .toString();
      } else {
        detail.ppn = "0";
      }
    }
  }

  sumTotalDiskon() {
    totalDiskon = 0;
    for (var i = 0; i < (dataPembelian.details?.length ?? 0); i++) {
      totalDiskon += double.parse(dataPembelian.details?[i].diskon ?? "0");
    }
  }

  sumTotalPpn() {
    totalPpn = 0;
    for (var i = 0; i < (dataPembelian.details?.length ?? 0); i++) {
      totalPpn += double.parse(dataPembelian.details?[i].ppn ?? "0");
    }
  }

  sumTotalNilaiBeli() {
    totalHargaBeli = 0;
    for (var i = 0; i < (dataPembelian.details?.length ?? 0); i++) {
      totalHargaBeli +=
          double.parse(dataPembelian.details?[i].totalNilaiBeli ?? "0");
    }
    totalHargaBeli = totalHargaBeli + totalPpn;
  }

  sumTotalNilaiJual() {
    totalHargaJual = 0;
    for (var i = 0; i < (dataPembelian.details?.length ?? 0); i++) {
      totalHargaJual +=
          double.parse(dataPembelian.details?[i].totalNilaiJual ?? "0");
    }
  }

  List<PlutoRow> rows = [];
  List<PlutoColumn> columns = [];

  initRow() {
    rows.clear();

    var dataList = dataPembelian.toJson()["details"] as List<dynamic>;

    rows = dataList.map<PlutoRow>((item) {
      Map<String, PlutoCell> cells = {};

      (item as Map<String, dynamic>).forEach((key, value) {
        cells[key] = PlutoCell(
          value: trimStringStrip(value.toString()),
        );
      });

      return PlutoRow(cells: cells);
    }).toList();
  }

  initColumn() {
    columns.clear();
    columns.addAll([
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari ID Produk",
        title: 'ID Produk',
        field: 'id_product',
        type: PlutoColumnType.text(),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerEmpty(),
                if (isPpn) const ContainerEmpty(),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Divisi",
        title: 'Divisi',
        field: 'nm_divisi',
        type: PlutoColumnType.text(),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerFooterText(text: "Diskon"),
                if (isPpn) const ContainerFooterText(text: "PPN"),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                  child: Text(
                    "TOTAL",
                    style: myTextTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Nama Produk",
        title: 'Nama Produk',
        field: 'nm_produk',
        type: PlutoColumnType.text(),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerEmpty(),
                if (isPpn) const ContainerEmpty(),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Harga Beli",
        title: 'Harga Beli',
        field: 'harga_beli',
        type: PlutoColumnType.number(
          locale: 'id',
        ),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerEmpty(),
                if (isPpn) const ContainerEmpty(),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Harga Jual",
        title: 'Harga Jual',
        field: 'harga_jual',
        type: PlutoColumnType.number(
          locale: 'id',
        ),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerEmpty(),
                if (isPpn) const ContainerEmpty(),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Qty",
        title: 'Qty',
        field: 'jumlah',
        type: PlutoColumnType.number(
          locale: 'id',
        ),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerEmpty(),
                if (isPpn) const ContainerFooterText(text: "11 %"),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                  child: PlutoAggregateColumnFooter(
                    rendererContext: context,
                    type: PlutoAggregateColumnType.sum,
                    titleSpanBuilder: (text) {
                      return [
                        TextSpan(
                          text: text,
                          style: myTextTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ];
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Disc",
        title: 'Disc',
        field: 'diskon',
        type: PlutoColumnType.number(
          locale: 'id',
        ),
        footerRenderer: (context) {
          context.stateManager.columnFooterHeight = getRowHeigh();

          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                ContainerFooterText(
                  text: formatMoney(trimString(totalDiskon.toString())),
                ),
                if (isPpn) const ContainerEmpty(),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Total Nilai Beli",
        title: 'Total Nilai Beli',
        field: 'total_nilai_beli',
        type: PlutoColumnType.number(
          locale: 'id',
        ),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerEmpty(),
                if (isPpn)
                  ContainerFooterText(
                    text: formatMoney(trimString(totalPpn.toString())),
                  ),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      isDetail
                          ? formatMoney(trimString(
                              dataPembelian.totalHargaBeli.toString()))
                          : formatMoney(trimString(totalHargaBeli.toString())),
                      style: myTextTheme.displayLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      PlutoColumn(
        backgroundColor: primaryColor,
        filterHintText: "Cari Total Nilai Jual",
        title: 'Total Nilai Jual',
        field: 'total_nilai_jual',
        type: PlutoColumnType.number(
          locale: 'id',
        ),
        footerRenderer: (context) {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                const ContainerEmpty(),
                if (isPpn) const ContainerEmpty(),
                Container(
                  height: 49,
                  width: MediaQuery.of(globalContext).size.width,
                  decoration: const BoxDecoration(
                    color: gray100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      isDetail
                          ? formatMoney(trimString(
                              dataPembelian.totalHargaJual.toString()))
                          : formatMoney(trimString(totalHargaJual.toString())),
                      style: myTextTheme.displayLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ]);
  }

  @override
  void initState() {
    instance = this;
    GlobalReference().supplierReference();
    dataFuture = cariDataPembelian();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
